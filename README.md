# Description

## How to run the code
1. Download vagrant https://www.vagrantup.com/
2. Download virtual box https://www.virtualbox.org/wiki/Downloads
3. Open your shell of choice to the vagrant directory and run the following commands
`vagrant up`
4. When that completes successfully run:
`vagrant ssh`
5. Once in the shell clone, this repo to a directory of your choosing
6. CD into the directory and run
`psql`
7. Next, run:
`CREATE DATABASE tournament`
`\i tournament.sql`
This should successfully import the SQL code from tournament.sql, creating the necessary tables and views for the test code to run.
8. Exit the psql CLI and run:
`python tournament_test.py`
9. Observe that all tests pass sucessfully.

