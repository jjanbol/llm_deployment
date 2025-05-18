import os
import argparse
from vllm.entrypoints.openai.api_server import main

if __name__ == "__main__":
    default_port = int(os.environ.get("PORT", 8080))
    
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", type=str, default="0.0.0.0")
    parser.add_argument("--port", type=int, default=default_port)
    parser.add_argument("--model", type=str, default="Intelligent-Internet/II-Medical-7B-Preview")
    parser.add_argument("--model-path", type=str, default=None)
    parser.add_argument("--tensor-parallel-size", type=int, default=1)
    parser.add_argument("--gpu-memory-utilization", type=float, default=0.9)
    parser.add_argument("--dtype", type=str, default="half")
    parser.add_argument("--max-model-len", type=int, default=8192)
    
    
    args = parser.parse_args()
    
    if args.model_path:
        args.model = args.model_path
    
    main(args)