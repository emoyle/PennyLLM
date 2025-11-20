# About PennyLLM
Penny LLM is an open source project that started as an experiment in fine-tuning a large language model for penetration testing domain-specific knowledge.  

# Current State
The immediate goal is to fine-tune a 4-bit LLaMA-3.2-3B model on a single CUDA 8.6 GPU, using Unsloth to accelerate the training/runtime stack (patching vLLM, using bf16, enabling graph capture). Primary work so far has been dataset creation—building JSONL instruction corpora from security-relevant sources—and repeatedly refining a reproducible preprocessing pipeline that doesn’t rely on Unsloth’s higher-level helpers. 

# Immediate Challenges 
Friction around opaque automation, pinned-memory issues under WSL, and keeping a small-VRAM training environment stable. The overarching goal is a clean LoRA fine-tuning workflow for a pentesting/ops-assistant model with deterministic data prep.

