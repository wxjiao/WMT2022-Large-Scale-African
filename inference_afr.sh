#!/bin/bash
#set -x
#
# sh [Your-Workspace]/inference.sh [Path-To-Model] srclang tgtlang batchsize srctext outputdir
# [Your-Workspace] means the path to this submission, e.g., 'xxx/xxx/submission_contrast' for absolute path or './submission_contrast' for relative path

#WORKSPACE=[Your-Workspace]
WORKSPACE=.
MODEL=$1
SRC=$2
TGT=$3
BATCH=$4
SRCTEXT=$5
OUTDIR=$6

# This local installation is required but only once
#pip3 install -e $WORKSPACE/fairseq
#pip3 install sacrebleu --upgrade

python3 $WORKSPACE/fairseq/scripts/spm_encode.py --model $WORKSPACE/${MODEL}/sentencepiece.bpe.model --inputs $WORKSPACE/${SRCTEXT} --outputs $WORKSPACE/${OUTDIR}/spm.test.${SRC} --output_format piece


LangPair=$WORKSPACE/${MODEL}/lang_pairs_7g106.txt
LangDict=$WORKSPACE/${MODEL}/langs.txt

python3 $WORKSPACE/fairseq/fairseq_cli/preprocess.py -s ${SRC} --only-source --testpref $WORKSPACE/${OUTDIR}/spm.test \
        --destdir $WORKSPACE/${OUTDIR} --workers 16 --srcdict $WORKSPACE/${MODEL}/dict.eng.txt

cd $WORKSPACE/${OUTDIR}
ln -s dict.$SRC.txt dict.${TGT}.txt
ln -s test.$SRC-None.${SRC}.idx test.$SRC-$TGT.$SRC.idx
ln -s test.$SRC-None.${SRC}.bin test.$SRC-$TGT.$SRC.bin
ln -s test.$SRC-None.${SRC}.idx test.$SRC-$TGT.$TGT.idx
ln -s test.$SRC-None.${SRC}.bin test.$SRC-$TGT.$TGT.bin
cd ../


CUDA_VISIBLE_DEVICES=0 python3 $WORKSPACE/fairseq/fairseq_cli/generate.py $WORKSPACE/${OUTDIR}/ \
  -s ${SRC} -t ${TGT} \
  --path $WORKSPACE/${MODEL}/checkpoint_best.pt \
  --task 'translation_multi_simple_epoch' \
  --gen-subset 'test' \
  --batch-size ${BATCH} \
  --beam '4' \
  --lenpen '1.0' \
  --remove-bpe 'sentencepiece' \
  --encoder-langtok "src" \
  --decoder-langtok \
  --lang-dict $LangDict \
  --lang-pairs $LangPair \
  > $WORKSPACE/${OUTDIR}/test.$SRC-$TGT.log

cat $WORKSPACE/${OUTDIR}/test.$SRC-$TGT.log | grep -P "^H" | sort -V | cut -f 3- > $WORKSPACE/${OUTDIR}/test.$SRC-$TGT.hyp

cd $WORKSPACE/${OUTDIR}
rm dict.*.txt
rm spm.test.${SRC}
rm test.*.idx
rm test.*.bin
rm test.*.log
cd ../

