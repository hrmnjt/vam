import click
import logging

logging.basicConfig(level=logging.DEBUG)
# logging.debug('This message should go to the log file')
# logging.info('So should this')
# logging.warning('And this, too')
# logging.error('And non-ASCII stuff, too, like Øresund and Malmö')

@click.group()
def cli():
    pass


@cli.command()
def init():
    click.echo("Initializing...")


@cli.command()
def validate():
    click.echo("Validating...")


@cli.command()
def plan():
    click.echo("Planning...")


@cli.command()
def apply():
    click.echo("Apply...")


if __name__ == "__main__":
    cli()
