import json

transcript_path = "/Users/polinapogosyan/.gemini/antigravity/brain/786727cf-c97b-454b-ba59-4fa0b6d3e77a/.system_generated/logs/transcript_full.jsonl"
target_files = ["notifications_screen", "email_check_screen", "phone_check_screen", "file_check_screen"]

with open(transcript_path, 'r') as f:
    for line in f:
        try:
            entry = json.loads(line)
        except:
            continue
        if entry.get("type") == "PLANNER_RESPONSE" and "tool_calls" in entry:
            for call in entry["tool_calls"]:
                name = call.get("name")
                args = call.get("args", {})
                if name == "run_command":
                    cmd = args.get("CommandLine", "")
                    for tf in target_files:
                        if tf in cmd:
                            step = entry.get("step_index")
                            print(f"Step {step}: run_command with {tf}\nCommand: {cmd[:100]}...")
