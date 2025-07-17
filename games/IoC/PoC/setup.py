from setuptools import find_packages, setup

with open("README.md") as fin:
    readme = fin.read()

with open('LICENSE') as fin:
    license = fin.read()


setup(
    name="Inversion of Control",
    version="0.1.0",
    description="Simple game based on famous Pac Man",
    long_description=readme,
    author="Pavel Tisnovsky",
    author_email="tisnik@centrum.cz",
    url="https://github.com/tisnik/8bit-fame/tree/master/games/IoC/PoC",
    license=license,
    packages=find_packages(exclude=("tests", "docs"))
)
