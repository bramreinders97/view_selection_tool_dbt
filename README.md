## ViewSelectionAdvisor

Welcome to `ViewSelectionAdvisor`, a tool designed to help dbt users address the problem of model materialization. 
This tool consists of two separate packages, each hosted in its own GitHub repository:
* [A dbt package](https://github.com/bramreinders97/view_selection_tool_dbt). 
This package is dependent on another dbt package: [Elementary](https://docs.elementary-data.com/guides/modules-overview/dbt-package)
* [A python package](https://github.com/bramreinders97/view_selection_tool_python)

## Package Explanation
### What does it do?
Most dbt projects are structured with a DAG that includes staging, intermediate, and marts models. Typically, staging and intermediate models are stored as views, while marts models are stored as tables. However, this default configuration may not always be the most efficient from a performance perspective. Determining which models should be materialized and which should not can be challenging.
This is where `ViewSelectionAdvisor` comes in to help. By using this tool, you are advised on the best 
materialization strategy for you models in dbt. 


### How does it work?
`ViewSelectionAdvisor` determines the optimal configuration of materialized models by evaluating all possible configurations. For each configuration, it estimates the total cost of building your entire DAG using PostgreSQL's `EXPLAIN` command.

Note: `ViewSelectionAdvisor` assumes that all [destination nodes](## "Destination nodes are nodes in your DAG without an outgoing edge. In most cases, these nodes correspond to mart tables.") are already materialized as tables. Consequently, these nodes will not appear in the provided advice.


## Installation Instructions
We assume you have a working dbt project for which you want advice. If so, follow the following
steps:
 
### dbt part
1. Include `ViewSelectionAdvisor` in your `packages.yml` file:
    ```yaml
      - git: "https://github.com/bramreinders97/view_selection_tool_dbt.git"
        revision: 6650cb7327d2ff2e3363b0cfddd233bcc6c4dbc6
    ``` 
 
2. Update your `dbt_project.yml` file:

    - **Schema Configuration**:
      Specify the schema appendix where dbt should store the relevant tables:
      ```yaml
        models:
          elementary:
            +schema: elementary
          view_selection_tool:
            +schema: view_selection_tool
      ```
      These settings ensure that if your project's tables are stored in schema `x`, then the tables from `elementary` will be stored in `x_elementary`, and those from `ViewSelectionAdvisor` will be stored in `x_view_selection_tool`.

    - **Variable Configuration**:
      Set the following variables:
      ```yaml
        vars:
          view_selection_tool:
            # Database where the elementary tables are located
            # (same as in your target profile from profiles.yml)
            elementary_src_db:  

            # Schema where the elementary tables are stored (e.g., `x_elementary`)
            src_schema:  

            # Name of your project as specified in this dbt_project.yml
            relevant_package:  
      ```
      This information allows `ViewSelectionAdvisor` to identify the data sources (`elementary_src_db` and `src_schema`) and the models to focus on (`relevant_package`).


3. Import the packages and build Elementary models
   ```shell
   dbt deps
   dbt run --select elementary
   ```
   This will install both the `view_selection_tool` and `elementary` packages, and create empty tables for Elementary to fill (at schema `x_elementary`).



### Python part

4. Install the package using your preferred method:
   ```shell
   pip install view_selection_tool
   ```
   or
   ```shell
   poetry add view_selection_tool
   ```


## Usage Instructions
Because `ViewSelectionAdvisor` relies entirely on the tables created by Elementary, it is crucial to ensure these tables are populated with the necessary information before running `ViewSelectionAdvisor`. Whenever you want to receive advice on the materialization of a DAG in dbt, follow these steps:

1. Populate Elementary tables with the latest information:
   ```shell
   dbt run --select <your_project_name>
   ```
   Running your project populates the Elementary tables with the data required by ViewSelectionAdvisor.

   _Note: This command only runs the models in your project, not the individual models from Elementary. However, the on-run-end hook of Elementary will execute automatically and provide all the necessary data._


2. Run `ViewSelectionAdvisor`:
   
   - **Transform Info From Elementary**:
   ```shell
   dbt run --select view_selection_tool
   ```
   This transforms the information provided in the Elementary tables and
   fills the database schema `x_view_selection_tool` with all information the
   python part of the `ViewSelectionAdvisor` requires in order to give a proper advice.

   - **Transform Info From Elementary**:
   ```shell
   vst-advise
   ```
   This command compares all possible materialization configurations, and advises on the configuration with 
   the lowest estimated cost. 

### Possible Variables for `vst-advise`
The following variables can be used to change the behavior of `vst-advise`: 

| Option                                                                        | Description                                                                                                                                  |
|-------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| `-h`, `--help`                                                                | Show this help message and exit                                                                                                              |
| `-mm <MAX_MATERIALIZATIONS>`, `--max_materializations <MAX_MATERIALIZATIONS>` | Set the maximum number of models to consider for materialization. Higher values provide more options but may increase runtime. Default is 2. |
| `-p <PROFILE>`, `--profile <PROFILE>`                                         | Select the profile to use                                                                                                                    |
| `-t <TARGET>`, `--target <TARGET>`                                            | Select the target profile to use                                                                                                             |


