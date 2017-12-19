<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\Category;

/**
 * CategorySearch represents the model behind the search form about `common\models\Category`.
 */
class CategorySearch extends Category {

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['id', 'pid',  'weight', 'create_at','display','list_type', 'update_at',], 'integer'],
            [['name', 'bgimage','remark'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios() {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params) {
        $query = Category::find();
//        var_dump($query);
//        exit();
        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => ['pageSize' => 20],
            'sort' => [
                'defaultOrder' => ['id' => SORT_DESC],
                'attributes' => ['id', 'weight'],
            ],
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'pid' => $this->pid,
            'display' => $this->display,
            'weight' => $this->weight,
            'create_at' => $this->create_at,
            'update_at' => $this->update_at,
             'list_type' => $this->list_type,
             'remark' => $this->remark,
        ]);

        $query->andFilterWhere(['like', 'name', $this->name])
               ->andFilterWhere(['like', 'bgimage', $this->bgimage])
               ->andFilterWhere(['like', 'remark', $this->remark]);
        return $dataProvider;
    }

}
