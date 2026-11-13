# Agent-model-pair-Code-repair-with-custom-tooling-EDAN70

ssh maximilian@pascal.cs.lth.se

./llama.cpp/build-vulkan/bin/llama-server -ngl 99 -fa 1 -m /opt/huggingface/Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf --jinja --port 8765

new terminal:

ssh maximilian@pascal.cs.lth.se

cd edan70

podman pull ubuntu:24.04

podman build -t testc

podman run -it --rm testc

podman cp src/ d12633c43655:/workspace

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBSNAxqSpibcnovONKxUBcvSPm5qdJv/p3pkpen11XpW hu4320an-s@sde-pascal
