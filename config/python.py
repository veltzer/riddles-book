""" python deps for this project """

install_requires: list[str] = [
    "numpy",
    "BitVector",
    "tqdm",
]
build_requires: list[str] = [
    "pydmt",
    "pymakehelper",
]
test_requires: list[str] = [
    "pylint",
]
requires = install_requires + build_requires + test_requires
