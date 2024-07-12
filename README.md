## ViewSelectionAdvisor
Welcome to `ViewSelectionAdvisor`, a tool designed to inform dbt users about the problem of
model materialization. This tool consists of two separate packages working together, each with their
own GitHub repository:
* [A dbt package](https://github.com/bramreinders97/view_selection_tool_dbt)
* [A python package](https://github.com/bramreinders97/view_selection_tool_python)


## Installation Instructions
We assume you have a working dbt project for which you want advice. If so, follow the following
steps:

1. Install the dbt package `Elementary`:  
Follow the [installation instructions](https://docs.elementary-data.com/cloud/onboarding/quickstart-dbt-package)
provided by `Elementary`.


2. Do a `dbt run --select <your_project_name>`. Ensure that Elementary's `on-run-end`
hook has completed successfully. This step populates the Elementary tables with the 
necessary information for `ViewSelectionAdvisor`. 


3. Include `ViewSelectionAdvisor` to your `packages.yml` file:
    ```yaml
      - git: "https://github.com/bramreinders97/view_selection_tool_dbt.git"
        revision: 6650cb7327d2ff2e3363b0cfddd233bcc6c4dbc6
    ``` 

4. run `dbt deps`


5. In the `dbt_project.yml` file of your project, add:
    ```yaml
      models:
        view_selection_tool:
          +schema: view_selection_tool
    ```

6. In the `profiles.yml` file of your project, add:
    ```yaml
      view_selection_tool: # must be called this!
      outputs:
        default:
          type: postgres
          host: [hostname]
          port: [port]
          user: [username]
          password: [password]
          dbname: [database name]
          schema: [schema name] # view_selection_tool schema, usually [schema name]_view_selection_tool
          threads: [threads]
    ```

7. On lines 44-46 of the `dbt_project.yml` file _**inside `dbt_packages/view_selection_tool`**_, 
fill in the following variables:
   * `elementary_src_db`
   * `src_schema`
   * `relevant_package`


## Usage Instructions
1. run `dbt run --select view_selection_tool`. This fills the database with all information the
python part of the tool requires in order to give a proper advice.


2. Follow the instructions at 
[the GitHub page of the python part of `ViewSelectionAdvisor`](https://github.com/bramreinders97/view_selection_tool_python)
in order to obtain the final advise.