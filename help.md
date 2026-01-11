@39eff3dd861d:/# python -c "
with open('train_b200_fp16_epic.py', 'r') as f:
    code = f.read()
code = code.replace('use_torch_compile: bool = True', 'use_torch_compile: bool = False')
with open('train_b200_fp16_epic.py', 'w') as f:
    f.write(code)
print('torch.compile disabled!')
" && python train_b200_fp16_epic.py
torch.compile disabled!

======================================================================
EPIC B200 FP16 TRAINING - PyTorch 2.8+ Required
======================================================================
✅ PyTorch 2.8.0+cu128 - B200 compatible!
✅ Signal handlers registered for graceful shutdown

╔══════════════════════════════════════════════════════════════════════════════╗
║   ██████╗ ██████╗  ██████╗  ██████╗     ███████╗██████╗ ██╗ ██████╗         ║
║   ██╔══██╗╚════██╗██╔═████╗██╔═████╗    ██╔════╝██╔══██╗██║██╔════╝         ║
║   ██████╔╝ █████╔╝██║██╔██║██║██╔██║    █████╗  ██████╔╝██║██║              ║
║   ██╔══██╗██╔═══╝ ████╔╝██║████╔╝██║    ██╔══╝  ██╔═══╝ ██║██║              ║
║   ██████╔╝███████╗╚██████╔╝╚██████╔╝    ███████╗██║     ██║╚██████╗         ║
║   ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝     ╚══════╝╚═╝     ╚═╝ ╚═════╝         ║
║                    FP16 MAXIMUM PERFORMANCE TRAINING                         ║
║                    PyTorch 2.8+ | NVIDIA B200 Optimized                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
        
2026-01-07 14:01:31,805 | INFO | 🔍 Checking B200 environment...
2026-01-07 14:01:32,662 | INFO |    GPU: NVIDIA B200
2026-01-07 14:01:32,663 | INFO |    Memory: 178.4 GB
2026-01-07 14:01:32,664 | INFO |    CUDA: 12.8
2026-01-07 14:01:32,665 | INFO |    PyTorch: 2.8.0+cu128
2026-01-07 14:01:32,666 | INFO |    ✅ B200 GPU detected!
2026-01-07 14:01:32,667 | INFO |    ✅ FP16 enabled for maximum performance
2026-01-07 14:01:32,669 | INFO | ⚡ Configuring FP16 environment...
2026-01-07 14:01:32,670 | INFO |    ✅ GradScaler initialized
2026-01-07 14:01:32,671 | INFO |    ✅ FP16 environment ready!
2026-01-07 14:01:32,672 | INFO | 📦 Loading model: huihui-ai/Huihui-Qwen3-4B-Instruct-2507-abliterated
2026-01-07 14:01:37,187 | INFO | We will use 90% of the memory on device 0 for storing the model, and 10% for the buffer to avoid OOM. You can set `max_memory` in to a higher value to use more memory (at your own risk).
Loading checkpoint shards: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 2/2 [00:07<00:00,  3.80s/it]
2026-01-07 14:01:52,163 | INFO |    ✅ Loaded with Transformers
2026-01-07 14:01:52,172 | INFO |    📊 Trainable: 142,008,320 / 2,347,818,496 (6.05%)
2026-01-07 14:01:52,173 | INFO | ⚙️ Setting up optimizer...
2026-01-07 14:01:52,177 | INFO |    ✅ AdamW (fused=True)
2026-01-07 14:01:52,178 | INFO | 📚 Loading dataset: dataset/final_training/train.jsonl
2026-01-07 14:01:52,604 | INFO | PyTorch version 2.8.0+cu128 available.
2026-01-07 14:01:53,387 | INFO |    ✅ Loaded 76,164 examples
2026-01-07 14:01:54,047 | INFO | 🚀 Starting EPIC B200 FP16 Training!
2026-01-07 14:01:54,048 | INFO | ======================================================================
/usr/local/lib/python3.12/dist-packages/dill/_dill.py:414: PicklingWarning: Cannot locate reference to <class '__main__.B200FP16Trainer'>.
  StockPickler.save(self, obj, save_persistent_id)
/usr/local/lib/python3.12/dist-packages/dill/_dill.py:414: PicklingWarning: Cannot pickle <class '__main__.B200FP16Trainer'>: __main__.B200FP16Trainer has recursive self-references that trigger a RecursionError.
  StockPickler.save(self, obj, save_persistent_id)
Map: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 76164/76164 [00:01<00:00, 67619.89 examples/s]
/usr/local/lib/python3.12/dist-packages/huggingface_hub/utils/_deprecation.py:100: FutureWarning: Deprecated argument(s) used in '__init__': max_seq_length, dataset_text_field, packing. Will not be supported from version '1.0.0'.

Deprecated positional argument(s) used in SFTTrainer, please use the SFTConfig to set these arguments instead.
  warnings.warn(message, FutureWarning)
/usr/local/lib/python3.12/dist-packages/trl/trainer/sft_trainer.py:195: UserWarning: You passed a `packing` argument to the SFTTrainer, the value you passed will override the one in the `SFTConfig`.
  warnings.warn(
/usr/local/lib/python3.12/dist-packages/trl/trainer/sft_trainer.py:283: UserWarning: You passed a `max_seq_length` argument to the SFTTrainer, the value you passed will override the one in the `SFTConfig`.
  warnings.warn(
/usr/local/lib/python3.12/dist-packages/trl/trainer/sft_trainer.py:321: UserWarning: You passed a `dataset_text_field` argument to the SFTTrainer, the value you passed will override the one in the `SFTConfig`.
  warnings.warn(
Generating train split: 130 examples [00:02, 54.46 examples/s]
/usr/local/lib/python3.12/dist-packages/trl/trainer/sft_trainer.py:401: FutureWarning: `tokenizer` is deprecated and will be removed in version 5.0.0 for `SFTTrainer.__init__`. Use `processing_class` instead.
  super().__init__(
/usr/local/lib/python3.12/dist-packages/accelerate/accelerator.py:494: FutureWarning: `torch.cuda.amp.GradScaler(args...)` is deprecated. Please use `torch.amp.GradScaler('cuda', args...)` instead.
  self.scaler = torch.cuda.amp.GradScaler(**kwargs)
No label_names provided for model class `PeftModelForCausalLM`. Since `PeftModel` hides base models input arguments, if label_names is not given, label_names can't be set automatically within `Trainer`. Note that empty label_names list will be used instead.
2026-01-07 14:02:13,882 | INFO | ⏱️  Max training time: 96.0 hours
2026-01-07 14:02:13,884 | INFO | 💾 Auto-save every: 15 minutes
2026-01-07 14:02:13,886 | INFO | 💾 Checkpoint every: 100 steps
2026-01-07 14:02:13,887 | INFO | 💾 Keeping last: 20 checkpoints
2026-01-07 14:02:13,889 | INFO | 🔥 Training started!
2026-01-07 14:02:13,891 | INFO | ⚡ Graceful shutdown enabled - will save on Ctrl+C or server stop
  0%|                                                                                                                                                                                                                                               | 0/12 [00:00<?, ?it/s]huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
`use_cache=True` is incompatible with gradient checkpointing. Setting `use_cache=False`.
/usr/local/lib/python3.12/dist-packages/torch/utils/checkpoint.py:85: UserWarning: None of the inputs have requires_grad=True. Gradients will be None
  warnings.warn(
{'loss': 0.0269, 'grad_norm': 0.03304647281765938, 'learning_rate': 0.0, 'epoch': 0.24}                                                                                                                                                                                    
 42%|████████████████████████████████████████████████████████████████████████████████████████████████▎                                                                                                                                      | 5/12 [00:14<00:16,  2.30s/it]huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
{'loss': 0.0255, 'grad_norm': 0.05874323099851608, 'learning_rate': 3.45139266054715e-05, 'epoch': 2.0}                                                                                                                                                                    
 83%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████▋                                      | 10/12 [00:28<00:04,  2.24s/it]huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...
To disable this warning, you can either:
        - Avoid using `tokenizers` before the fork if possible
        - Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 12/12 [00:35<00:00,  2.83s/it]/usr/local/lib/python3.12/dist-packages/peft/utils/save_and_load.py:202: UserWarning: Setting `save_embedding_layers` to `True` as embedding layers found in `target_modules`.
  warnings.warn("Setting `save_embedding_layers` to `True` as embedding layers found in `target_modules`.")
{'train_runtime': 41.4612, 'train_samples_per_second': 9.406, 'train_steps_per_second': 0.289, 'train_loss': 0.025618250637004774, 'epoch': 2.47}                                                                                                                          
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 12/12 [00:41<00:00,  3.46s/it]
2026-01-07 14:02:56,097 | INFO | 💾 Saving final model...
/usr/local/lib/python3.12/dist-packages/peft/utils/save_and_load.py:202: UserWarning: Setting `save_embedding_layers` to `True` as embedding layers found in `target_modules`.
  warnings.warn("Setting `save_embedding_layers` to `True` as embedding layers found in `target_modules`.")
2026-01-07 14:03:03,198 | INFO | 💾 Backup saved to: output_b200_fp16/final_backup_20260107_140259
2026-01-07 14:03:03,200 | INFO | ======================================================================
2026-01-07 14:03:03,201 | INFO | 🎉 EPIC TRAINING COMPLETE!
2026-01-07 14:03:03,203 | INFO |    Total time: 0:01:09
2026-01-07 14:03:03,204 | INFO |    Final loss: 0.0256
2026-01-07 14:03:03,206 | INFO |    Output: output_b200_fp16

🎉 Epic training session complete!
🔄 Exit detected - ensuring final save...
🚨 EMERGENCY SAVE to output_b200_fp16/emergency_exit_cleanup_20260107_140303
✅ Emergency save complete: output_b200_fp16/emergency_exit_cleanup_20260107_140303
root@39eff3dd861d:/# 2