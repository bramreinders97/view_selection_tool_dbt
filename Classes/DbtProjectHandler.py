import os
import json
from typing import Dict
from dbtModel import DbtModel


class DbtProjectHandler:

    def __init__(self, dbt_root_folder_path: os.path):
        self.root_folder_path = dbt_root_folder_path
        self.dict_of_models = self._create_models_dict()

    def _get_manifest_path(self) -> os.path:
        return os.path.join(self.root_folder_path, "target", "manifest.json")

    def _read_manifest(self) -> Dict:
        path = self._get_manifest_path()
        with open(path, 'r') as manifest_json:
            manifest_dict = json.load(manifest_json)
        return manifest_dict

    def _create_models_dict(self) -> Dict[str, DbtModel]:
        manifest_dict = self._read_manifest()
        nodes_dict = manifest_dict["nodes"]

        dict_of_models = {}

        for _, full_node_info_dict in nodes_dict.items():
            model_name = full_node_info_dict["name"]
            dict_of_models[model_name] = DbtModel(full_info_dict=full_node_info_dict)

        return dict_of_models


test = DbtProjectHandler(dbt_root_folder_path="C:/Users/bramr/OneDrive/Documenten/Blenddata/Initiële uitwerkingen "
                                              "opdrachten/DBT/Code/dbt_chatGPT_suggestion/dbt")

print(test.dict_of_models['int_accounts_and_groups_joined'])