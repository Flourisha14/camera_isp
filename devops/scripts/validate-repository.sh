#!/usr/bin/env bash

set -euo pipefail

echo "========================================"
echo "Rove Tech — Repository Validation"
echo "========================================"

cd "$(git rev-parse --show-toplevel)"

echo
echo "[1/5] Checking repository structure..."

required_files=(
    "README.md"
    ".gitignore"
    ".gitattributes"
    "docs/architecture/source-provenance.md"
)

required_dirs=(
    ".github/workflows"
    "docs/requirements"
    "docs/architecture"
    "docs/qa"
    "devops/scripts"
    "kas"
    "meta-isp-assignment"
    "app"
    "tests"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "ERROR: Missing required file: $file"
        exit 1
    fi
done

for dir in "${required_dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
        echo "ERROR: Missing required directory: $dir"
        exit 1
    fi
done

echo "PASS: Repository structure"

echo
echo "[2/5] Checking Git whitespace..."

git diff --check HEAD^

echo "PASS: Whitespace validation"

echo
echo "[3/5] Checking shell script syntax..."

while IFS= read -r -d '' script; do
    echo "Checking: $script"
    bash -n "$script"
done < <(find . \
    -path './.git' -prune -o \
    -type f -name '*.sh' -print0)

echo "PASS: Shell syntax"

echo
echo "[4/5] Checking Python syntax..."

python3 - <<'PY'
import ast
import pathlib

for path in pathlib.Path(".").rglob("*.py"):
    if ".git" in path.parts:
        continue

    print(f"Checking: {path}")

    with path.open("r", encoding="utf-8") as source:
        ast.parse(source.read(), filename=str(path))

print("PASS: Python syntax")
PY

echo
echo "[5/5] Checking tracked artifacts..."

forbidden_patterns=(
    '\.vmdk$'
    '\.vmx$'
    '\.env$'
    '\.pem$'
    '\.key$'
    '/tmp/'
    '/sstate-cache/'
    '/downloads/'
)

tracked_files="$(git ls-files)"

for pattern in "${forbidden_patterns[@]}"; do
    if echo "$tracked_files" | grep -E "$pattern"; then
        echo "ERROR: Forbidden tracked artifact detected"
        exit 1
    fi
done

echo "PASS: Repository hygiene"

echo
echo "========================================"
echo "ALL VALIDATION CHECKS PASSED"
echo "========================================"