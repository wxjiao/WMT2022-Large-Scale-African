# WMT2022-Large-Scale-African

This project introduces Tencent’s Multilingual Machine Translation System for the WMT2022 Large-Scale African Translation shared task.

We (team Borderline) won the [<b>1st</b> place :1st_place_medal:](https://docs.google.com/spreadsheets/d/1NHwPkIK7b5pjTcnZdlH1cxS_orbISjdOv5V12aHj1iY/edit#gid=1337958767) in the constrained track (i.e., external data and pretrained models are not allowed).

<div align="center">
<figure>
  <img width="1490" alt="WMT22_Results_20220929" src="https://user-images.githubusercontent.com/31032829/192919953-12206e7c-9b32-4039-b26f-bda6111dfbb8.png">
  <figcaption><b>Competition Results on the Blind Test Sets</b> (By 2022/09/29)</figcaption>
</figure>
</div>


## Test our Pretrained Model

### Config the Local Environment for Evaluation

Let us assume we are provided with a clean machine, then we have the following steps:
- Download [Miniconda3 py37_4.10.3](https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh), and see [Instruction](https://conda.io/projects/conda/en/latest/user-guide/install/linux.html) to install.
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


### Download our Pretrained Model

- Due to the storage limit, we only release the [contrastive submission](https://huggingface.co/wxjiao/wmt22-large-scale-african), which include our code, sentencepiece model, and pretrained model.
```
# decompress and obtain `submission_contrast`
unzip submission_contrast.zip
```

- Use the `inference_afr.sh` for inference.
```
# update the `inference_afr.sh` file with the one provided in this repo
cd submission_contrast
pip install -e ./fairseq

# sh ./inference_afr.sh MODEL_PATH SRC_LANG TGT_LANG BATCH_SIZE SRC_TEXT OUTPUT_DIR
sh ./inference_afr.sh models/trans_deepwide_dp020_african26_7g106_erm3_ft30k fra eng 16 data/test.fr output
```

<b>Note</b>: Training instruction is coming soon.



## Public Impact
### Citation
Please kindly cite our paper if you find it helpful:

```ruby
@inproceedings{jiao2022wmt,
  title={Tencent’s Multilingual Machine Translation System for WMT22 Large-Scale African Languages},
  author={Wenxiang Jiao and Zhaopeng Tu and Jiarui Li and Wenxuan Wang and Jen-tse Huang and Shuming Shi},
  booktitle = {WMT},
  year      = {2022}
}
```

