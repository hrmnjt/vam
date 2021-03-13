"""Managing command line options for vertica access management

Classes:


Functions:


Misc variables:

    __author__
    __version__
    __license__

"""

__author__ = "hrmnjt"
__version__ = "0.1.0"
__license__ = "Apache 2.0"

import argparse
import logging


def main():
    """Main entry point for module
    ..
    ..
    """
    logging.info("hello world")
    logging.info(args)


parser = argparse.ArgumentParser(
    description="Vertica access management",
)
parser.add_argument("init", help="an integer for the accumulator")
parser.add_argument(
    "--sum",
    dest="accumulate",
    action="store_const",
    const=sum,
    default=max,
    help="sum the integers (default: find the max)",
)

args = parser.parse_args()
print(args.accumulate(args.integers))
