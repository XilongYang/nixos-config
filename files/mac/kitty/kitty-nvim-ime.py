import base64
import os
import subprocess

ENGLISH = "com.apple.keylayout.ABC"
MACISM = "@macism@"
STATE_FILE = f"/tmp/kitty-nvim-ime-last-{os.environ.get('USER', 'user')}"


def _macism(*args):
    try:
        result = subprocess.run(
            (MACISM, *args),
            check=False,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True,
        )
    except Exception:
        return ""
    return result.stdout.strip()


def _read_last():
    try:
        with open(STATE_FILE, "r", encoding="utf-8") as f:
            return f.readline().strip()
    except OSError:
        return ""


def _write_last(value):
    if value:
        try:
            with open(STATE_FILE, "w", encoding="utf-8") as f:
                f.write(value + "\n")
        except OSError:
            pass


def _switch_to_normal():
    current = _macism()
    if current:
        _write_last(current)
    if current != ENGLISH:
        _macism(ENGLISH)


def _switch_to_insert():
    saved = _read_last()
    if saved:
        _macism(saved)


def _value(data):
    value = data.get("value")
    if isinstance(value, bytes):
        return value.decode("utf-8", "ignore")
    value = value or ""
    if value in ("insert", "normal"):
        return value
    try:
        return base64.b64decode(value).decode("utf-8", "ignore")
    except Exception:
        return value


def on_set_user_var(boss, window, data):
    if data.get("key") != "NVIM_MODE":
        return

    mode = _value(data)
    if mode == "insert":
        _switch_to_insert()
    elif mode == "normal":
        _switch_to_normal()
