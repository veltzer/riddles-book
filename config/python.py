import config.project

package_name = config.project.project_name

config_requires = [
    "pyclassifiers",
]
make_requires = [
    "pymakehelper",
]
install_requires = [
    "numpy",
    "BitVector",
]

python_requires = ">=3.10"

test_os = ["ubuntu-22.04"]
test_python = ["3.10"]
