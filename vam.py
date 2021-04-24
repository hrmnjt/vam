# import click
import logging
import toml
import vertica_python

logging.basicConfig(level=logging.INFO)
# logging.debug('This message should go to the log file')
# logging.info('So should this')
# logging.warning('And this, too')
# logging.error('And non-ASCII stuff, too, like Øresund and Malmö')

# @click.group()
# def cli():
#     pass


# @cli.command()
# def init():
#     click.echo("Initializing...")


# @cli.command()
# def validate():
#     click.echo("Validating...")


# @cli.command()
# def plan():
#     click.echo("Planning...")


# @cli.command()
# def apply():
#     click.echo("Apply...")


def get_vertica_table(query):

    secrets = toml.load("config.toml")

    conn_info = {
        "host": secrets["vertica"]["host"],
        "port": secrets["vertica"]["port"],
        "user": secrets["vertica"]["user"],
        "password": secrets["vertica"]["password"],
        "database": secrets["vertica"]["database"],
        "log_level": logging.ERROR,
    }

    with vertica_python.connect(**conn_info) as connection:
        cur = connection.cursor()
        cur.execute(query)
        rows = cur.fetchall()

    return rows


if __name__ == "__main__":
    # cli()
    logging.debug("Executing vam.py main method")

    users = get_vertica_table(
        """select user_name
                ,is_locked
                ,grace_period
                ,idle_session_timeout
                ,max_connections
                ,memory_cap_kb
                ,profile_name
                ,resource_pool
                ,run_time_cap
                ,search_path
                ,temp_space_cap_kb
            from users;
        """
    )
    print(users)
