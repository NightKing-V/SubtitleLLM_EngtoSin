# 📘 English-to-Sinhala Subtitle Translator (Experimental)

This project fine-tunes a multilingual machine translation model to translate English subtitle text into Sinhala. The experiment explores key NLP preprocessing techniques, model fine-tuning strategies, and post-training optimization for efficient deployment.

---

## 🗂️ Data Sources

Parallel subtitle data (English–Sinhala) was collected and cleaned from the following publicly available subtitle repositories:

- 🎞️ Sinhala Subtitle Archive: [sinhalasubtitle.net](https://sinhalasubtitle.net/tvseries/game-of-thrones-2011-sinhala-subtitles/)
- 📺 English Subtitle Archive: [tvsubtitles.net](https://www.tvsubtitles.net/tvshow-911-2.html)

> 🔹 Data was manually aligned and processed into JSON format for this experiment.  
> 🔹 All rights to the original content belong to the respective owners.
> 
---

## 🛠️ Technologies & Libraries

| Category                    | Tool / Library                        | Description |
|----------------------------|----------------------------------------|-------------|
| **Base Framework**         | 🤗 Transformers                        | Used for loading, tokenizing, training, and evaluating the translation model. |
| **Model Architecture**     | `facebook/mbart-large-50-many-to-many-mmt` | Multilingual BART model supporting 50 languages, suitable for many-to-many translation. |
| **Datasets**               | Custom JSON Subtitle Pairs             | Cleaned parallel corpus of English ↔ Sinhala subtitle segments. |
| **Tokenization**           | `MBart50TokenizerFast` (SentencePiece) | Handles multilingual subword tokenization with language-specific special tokens. |
| **Training**               | `Trainer`, `TrainingArguments`         | HuggingFace's built-in trainer for managing training loop, checkpointing, and evaluation. |
| **Evaluation**             | `sacrebleu`                             | BLEU score used to evaluate translation quality. |
| **GPU Acceleration**       | PyTorch + CUDA                         | GPU used for model fine-tuning and inference. |
| **Quantization**           | `bitsandbytes`, `BitsAndBytesConfig`   | 8-bit post-training quantization (PTQ) to reduce model size and speed up inference. |
| **Containerization**       | Docker + Docker Compose                | Reproducible environment for training and experimentation. |
| **Logging / Monitoring**   | `Trainer` built-in metrics             | Logs training/validation loss, steps per second, and more. |

---

## 🧪 Methods Used

### ✅ Data Processing
- Subtitle pairs were cleaned to remove missing values and HTML tags.
- Tokenization included language-specific prefix tokens (e.g., `en_XX`, `si_LK`) required by mBART.
- Data split into training and validation sets (90/10 split).

### ✅ Model Fine-Tuning
- Trained for 3 epochs with:
  - Learning rate: `2e-5`
  - Batch size: `8`
  - Mixed precision (`fp16`) enabled
  - Evaluation and checkpointing per epoch
- Fine-tuned model saved using `model.save_pretrained(...)`.

### ✅ Evaluation
- Used BLEU score to assess performance on a 50-pair subset.
- Score obtained: **2.24 BLEU** (baseline — limited by very small dataset).

### ✅ Optimization
- Applied **8-bit quantization** using `bitsandbytes` to reduce memory usage.
- Quantized model loaded with `device_map="auto"` for automatic GPU usage.

---

## 🚧 Limitations

- Low BLEU score due to limited training data and lack of extensive hyperparameter tuning.
- Not production-ready; intended as a baseline experiment.

---

## 💡 Future Plans

- Train on larger subtitle datasets for improved quality.
- Integrate LoRA or QLoRA for efficient fine-tuning.
- Export model to ONNX or TorchScript for mobile/edge deployment.
- Evaluate using human feedback and additional metrics (e.g., METEOR, chrF).

---
