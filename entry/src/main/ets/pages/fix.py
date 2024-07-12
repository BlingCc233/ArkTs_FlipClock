import json
import re

def fix_json_keys(json_str):
    # 正则表达式匹配未加引号的 key
    pattern = re.compile(r'(?<!")(\b\d+\b)(?!")(?=\s*:)', re.MULTILINE)
    fixed_json_str = pattern.sub(r'"\1"', json_str)
    return fixed_json_str

# 读取输入的 JSON 文件
with open('homo.json', 'r') as file:
    json_str = file.read()

# 修复 JSON key
fixed_json_str = fix_json_keys(json_str)

# 将修复后的 JSON 字符串写入新的文件
with open('output.json', 'w') as file:
    file.write(fixed_json_str)

print("修复完成，结果保存在 output.json 文件中。")

