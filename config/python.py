""" python dependencies """

from typing import List


config_requires: List[str] = []
dev_requires: List[str] = [
]
install_requires: List[str] = [
    "numpy",
    "BitVector",
    "tqdm",
]
build_requires: List[str] = [
    "pymakehelper",
    "pyclassifiers",
    "pydmt",
    "pylint",
]
test_requires: List[str] = []
requires = config_requires + install_requires + build_requires + test_requires
