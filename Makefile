all: build

build: cb85/dec.pyx cb85/dec.pxd cb85/enc.pyx cb85/enc.pxd
	python3 setup.py build_ext --inplace
	python3 setup.py sdist bdist_wheel
	auditwheel repair dist/*.whl

clean:
	rm -rf build/ cb85/__pycache__/ cb85/*.so cb85/*.c dist/ cb85.egg-info/ wheelhouse/

upload: build
	python3 -m twine upload wheelhouse/*

bench: build
	python3 -m timeit -u usec -s 'from base64 import b85encode ; x = bytes(range(256))' 'b85encode(x)'
	python3 -m timeit -u usec -s 'from cb85 import b85encode ; x = bytes(range(256))' 'b85encode(x)'

	python3 -m timeit -u usec -s 'from base64 import b85decode, b85encode ; x = b85encode(bytes(range(256)))' 'b85decode(x)'
	python3 -m timeit -u usec -s 'from cb85 import b85decode, b85encode ; x = b85encode(bytes(range(256)))' 'b85decode(x)'

test: build
	python3 -m unittest
