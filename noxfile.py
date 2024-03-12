"""Nox sessions for testing and linting."""

#python -m nox -rs lint_sql

import nox
from nox_poetry import Session

nox.options.sessions = "lint"
locations_sql = ["view_selection_tool/models", "view_selection_tool/macros"]


@nox.session(python=["3.11.5"])
def format_sql(session: Session) -> None:
    """Run SQLfluff fix formatter."""
    args = session.posargs or locations_sql
    session.install(
        "dbt-core==1.6.4",
        "dbt-postgres==1.6.4",
        "sqlfluff==2.3.5",
        "sqlfluff-templater-dbt==2.3.5",
    )
    session.run("sqlfluff", "fix", "--dialect", "postgres", "-f", *args)


@nox.session(python=["3.11.5"])
def lint_sql(session: Session) -> None:
    """Lint using SQLfluff."""
    args = session.posargs or locations_sql
    session.install(
        "dbt-core==1.6.4",
        "dbt-postgres==1.6.4",
        "sqlfluff==2.3.5",
        "sqlfluff-templater-dbt==2.3.5",
        "sqlalchemy==2.0.26",
        "pandas==2.1.3"
    )
    session.run("dbt", "deps", "--project-dir", "view_selection_tool")
    session.run("sqlfluff", "lint", "--dialect", "postgres", *args)
