#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name='chocotools',
    version='0.2',
    description='Chocolatey tools',
    packages=['chocotools'],
    # requires=['aiohttp',
              # 'aiosocks',
              # 'sqlalchemy',
              # 'markovify',
              # 'numpy'],
    entry_points={
        'console_scripts': [
            'chocotools=chocotools:main',
        ],
    },
 )