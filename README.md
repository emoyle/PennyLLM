# About PennyLLM
Penny LLM is an open source project that started as an experiment in fine-tuning a large language model for penetration testing domain-specific knowledge.  Specifically, a repeatable fine-tuning workflow for LLaMA-family models (or similar) using Unsloth as the acceleration layer. The target is a “pentesting/security-assistant” model trained on custom data (e.g., JSONL corpora extracted from man-pages and other security references). Current plan is to iteratw toward a stable environment bypassing toolchain churn and avoiding unnecessary Unsloth "magic" where possible.

# Why do this at all?
The goals of this project are twofold.  1) Commercial LLMs (and many open source models) often - due to guardrails - will not provide useable advice on attacks, exploits, vulnerabilities, or other mandatory activities to conduct red team testing or similar offensive security activies. 2) To build intuition about LLM engineering, fine tuning, and other technical aspects of LLM engineering. 

# Current State
The immediate goal is to fine-tune a 4-bit LLaMA-3.2-3B model on a single CUDA 8.6 GPU, using Unsloth to accelerate the training/runtime stack (patching vLLM, using bf16, enabling graph capture). Primary work so far has been dataset creation—building JSONL instruction corpora from security-relevant sources—and repeatedly refining a reproducible preprocessing pipeline that doesn’t rely on Unsloth’s higher-level helpers. 

# Immediate Challenges 
Friction around opaque automation, pinned-memory issues under WSL, and keeping a small-VRAM training environment stable. The overarching goal is a clean LoRA fine-tuning workflow for a pentesting/ops-assistant model with deterministic data prep.

# Test Environment
Tested under:

- CUDA compute capability 8.6 GPUs
- 12 GB VRAM (driver for 4-bit quantization - bnb-4bit)
- WSL detected by Unsloth (forcing pin_memory=False)
- torch.bfloat16 (Unsloth auto-configure)
- using vLLM via Unsloth’s graph-capture patches

# Dataset
Dataset is a custom instruction-tuning corpus built from security-relevant technical material, primarily extracted from Linux/Kali man-pages and adjacent open-source tooling documentation. The structure is JSONL, formatted as instruction/response pairs intended to emulate a security-assistant or pentesting-assistant persona. The data focuses on system administration commands, security utilities, usage patterns, flags, option semantics, and short procedural explanations. 

# Ethical Considerations
There is a gap right now for professional offensive security practitioners where commercial model guardrails block necessary technical guidance for authorized activities. The underlying knowledge (attack techniques, vulnerability exploitation, tool usage) is already publicly available through existing documentation and open-source tools. This project simply provides a more accessible interface for professionals who require it in their legitimate work. 

While all security tools are inherently dual-use (i.e., useful for both attacker and defender), the ethical distinction between publishing a beneficial or malicious tool lies (in my opinion) in responsible deployment. Therefore, as this tool is intended for authorized security work within legal and ethical boundaries (and not for malicious activity), I currently DO NOT INTEND to EVER offer the fine tuned model in completed form.  Instead, I intend to publish the underlying artifacts (scripts, code, etc.) sufficient to allow a researcher or engineer to reproduce the training. Depending on the utility of the finished product, I may consider introducing a deliberate error or two that can be removed by an engineer or researcher, but would disallow easy access to (for example) one-click exploit generation or similar (assuming it works that well, which it may not).  I may revisit this in the future depending on performance.
