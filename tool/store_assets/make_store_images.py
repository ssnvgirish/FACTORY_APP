"""Prepares Play Store listing images.

  - Phone screenshots -> store_assets/phone/NN_*.png at 1080x2160 (9:16 is within
    Play's 2:1 max aspect ratio; short side >= 320px).
    Source captures are letterboxed to 2:1 by padding with each screen's own edge colour,
    so the content is never stretched.
  - Feature graphic -> store_assets/feature_graphic_1024x500.png

    PYTHONPATH=/path/to/pillow python3 tool/store_assets/make_store_images.py
"""
import glob
import os

from PIL import Image, ImageDraw, ImageFont

SRC_DIR = "/Users/gnaga/.cursor/projects/Users-gnaga-factory-app/assets"
OUT = "store_assets"
PHONE_W, PHONE_H = 1080, 2160
CREAM = (251, 247, 241)
NAVY = (27, 40, 56)
AMBER = (255, 160, 0)
FONT_BOLD = "google_fonts/SourceSans3-Bold.ttf"
FONT_REG = "google_fonts/SourceSans3-Regular.ttf"
LOGO = "assets/images/wudsy_nfc_logo.png"

NAMES = [
    "01_splash",
    "02_home_frames",
    "03_home_sheets",
    "04_home_scrap_regrind",
    "05_admin_panel",
]


def phone_screenshot(src, dst):
    im = Image.open(src).convert("RGB")
    # Scale to full height, keep aspect ratio, then pad sides to 1080 wide.
    w = round(im.width * PHONE_H / im.height)
    im = im.resize((w, PHONE_H), Image.LANCZOS)
    # Edge colour from the top-left and bottom-left screen pixels.
    left = im.crop((0, 0, 1, PHONE_H)).resize((1, 1), Image.BOX).getpixel((0, 0))
    canvas = Image.new("RGB", (PHONE_W, PHONE_H), left)
    canvas.paste(im, ((PHONE_W - w) // 2, 0))
    canvas.save(dst, optimize=True)
    print(dst, canvas.size, f"content {w}x{PHONE_H}")


def feature_graphic(dst):
    W, H = 1024, 500
    img = Image.new("RGB", (W, H), CREAM)
    d = ImageDraw.Draw(img)

    # Navy band on the right with the QC mark.
    d.rectangle((640, 0, W, H), fill=NAVY)

    logo = Image.open(LOGO).convert("RGB")
    # Use the same white-to-transparent key as the icon.
    from PIL import ImageChops

    r, g, b = logo.split()
    darkest = ImageChops.darker(ImageChops.darker(r, g), b)
    alpha = darkest.point(lambda v: min(255, int((255 - v) * 255 / 155)))
    rgba = logo.convert("RGBA")
    rgba.putalpha(alpha)
    rgba = rgba.crop(rgba.getbbox())
    lw = 520
    lh = round(rgba.height * lw / rgba.width)
    rgba = rgba.resize((lw, lh), Image.LANCZOS)
    img.paste(rgba, (60, 90), rgba)

    f_title = ImageFont.truetype(FONT_BOLD, 46)
    f_sub = ImageFont.truetype(FONT_REG, 30)
    d.text((60, 300), "Production quality control", font=f_title, fill=NAVY)
    d.text((60, 360), "Frames, sheets and scrap regrind reports", font=f_sub, fill=(70, 70, 70))

    f_qc = ImageFont.truetype(FONT_BOLD, 150)
    d.text((W - 200, H // 2), "QC", font=f_qc, fill=AMBER, anchor="mm")

    img.save(dst, optimize=True)
    print(dst, img.size)


def main():
    os.makedirs(f"{OUT}/phone", exist_ok=True)
    files = sorted(glob.glob(f"{SRC_DIR}/Screenshot_*.jpg"))
    assert len(files) == len(NAMES), f"expected {len(NAMES)} screenshots, found {len(files)}"
    for src, name in zip(files, NAMES):
        phone_screenshot(src, f"{OUT}/phone/{name}.png")
    feature_graphic(f"{OUT}/feature_graphic_1024x500.png")


if __name__ == "__main__":
    main()
