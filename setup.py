from setuptools import find_packages, setup
from Cython.Build import cythonize

setup(
    name='cb85',
    version='0.0.1',
    packages=find_packages(),
    author='Karl Sundequist Blomdahl',
    author_email='karl.sundequist.blomdahl@gmail.com',
    description='Cythonized Base85 encoder and decoder.',
    url='https://github.com/Chicoryn/cb85',
    license='Apache-2.0',
    ext_modules=cythonize(["cb85/dec.pyx", "cb85/enc.pyx"], language_level=3),
    zip_safe=False,
)
