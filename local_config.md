# WMT2022-African-MNMT
This repo details our preparation for the WMT2022 Large-Scale African Translation shared task.

## Config the Local Environment for Evaluation

Let us assume we are provided with a clean machine, then we have the following steps:
- Download [Miniconda3 py37_4.10.3](https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh), and see [Instruction](https://conda.io/projects/conda/en/latest/user-guide/install/linux.html) for to install.
```
# make sure your networks are well configured.
wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh
sh Miniconda3-py37_4.10.3-Linux-x86_64.sh

# three prompts during installing
# 1. Do you accept the license terms? [yes|no] 
#   yes
# 2. Miniconda3 will now be installed into this location: /home/username/miniconda3
#   ENTER
# 3. Do you wish the installer to initialize Miniconda3 by running conda init? [yes|no]
#   yes

source ~/.bashrc
```

- Install Pytorch 1.7.1 + CUDA 11.0.
```
# CUDA 11.0
pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
```

- Install `fairseq==0.10.2` and dependencies with `sub_requirements.txt`.
```
pip install -r sub_requirements.txt

# packages in sub_requirements.txt
tensorboardX
cffi
cython
dataclasses
hydra-core
numpy
regex
sacrebleu
tqdm
sacremoses
nltk>=3.2
matplotlib
absl-py
sentencepiece
setuptools>=18.0
fairseq==0.10.2
```

- Download our models with `sub_wmt22.sh`. (Skip this step if it is already downloaded)
```
# sh sub_wmt22.sh ACCTOK
sh sub_wmt22.sh ya29.a0AVA9y1sMTR1-he2TI2iuMnRziyTZLP8C_CwnsR8saS-SIVV5E0AqCALqpUY2wVTW5rFFoLh5PoNpf9Zxx2jlKpHKwA1ujOnvl3Cm4Etp-2mYz_8t0EKcWrpVmPPa64LgZ-g5XEI08caM37tvVLCby7QjqeHIaCgYKATASAQASFQE65dr8_Uw3nGAPY8VNGwV6f6HBmQ0163

# decompress and obtain `submission_contrast`
unzip temp.zip
```

- Use the `inference_afr.sh` for inference.
```
# replace the `inference_afr.sh` by the unpdated version if provided (see the attachments of our email)
cd submission_contrast
pip install -e ./fairseq

# sh ./inference_afr.sh MODEL_PATH SRC_LANG TGT_LANG BATCH_SIZE SRC_TEXT OUTPUT_DIR
sh ./inference_afr.sh models/trans_deepwide_dp020_african26_7g106_erm3_ft30k fra eng 16 data/test.fr output
```

