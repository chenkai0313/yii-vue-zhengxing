<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\Images;

/**
 * ImagesSearch represents the model behind the search form about `common\models\Images`.
 */
class ImagesSearch extends Images
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'create_at', 'update_at','display','weight'], 'integer'],
            [['img', 'url','name'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
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
    public function searchmember($params)
    {
        $query = Images::find()
           ->where(['type'=>2]);

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => ['pageSize' => 10],
            'sort' => [
                'defaultOrder' => ['weight' => SORT_DESC],
                'attributes' => [ 'weight'],
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
            'create_at' => $this->create_at,
            'update_at' => $this->update_at,
             'display' => $this->display,
             'weight' => $this->weight,
        ]);

        $query->andFilterWhere(['like', 'img', $this->img])
            ->andFilterWhere(['like', 'url', $this->url])
              ->andFilterWhere(['like', 'display', $this->display])
                 ->andFilterWhere(['like', 'weight', $this->weight]);

        return $dataProvider;
    }

#友情链接
       public function searchlinker($params)
    {
        $query = Images::find()
        ->where(['type'=>1]);
        $dataProvider = new ActiveDataProvider([
            'query' => $query,
                 'pagination' => ['pageSize' => 10],
            'sort' => [
                'defaultOrder' => ['weight' => SORT_DESC],
                'attributes' => [ 'weight'],
            ],
        ]);
        $this->load($params);
        if (!$this->validate()) {
            return $dataProvider;
        }
        $query->andFilterWhere([
            'id' => $this->id,
            'create_at' => $this->create_at,
            'update_at' => $this->update_at,
        ]);

        $query->andFilterWhere(['like', 'img', $this->img])
            ->andFilterWhere(['like', 'url', $this->url])
               ->andFilterWhere(['like', 'weight', $this->weight])
                  ->andFilterWhere(['like', 'display', $this->display]);

        return $dataProvider;
    }

    #服务大厅
       public function searchService($params)
    {
        $query = Images::find()
        ->where(['type'=>3]);
        $dataProvider = new ActiveDataProvider([
            'query' => $query,
                 'pagination' => ['pageSize' => 10],
            'sort' => [
                'defaultOrder' => ['weight' => SORT_DESC],
                'attributes' => [ 'weight'],
            ],
        ]);
        $this->load($params);
        if (!$this->validate()) {
            return $dataProvider;
        }
        $query->andFilterWhere([
            'id' => $this->id,
            'create_at' => $this->create_at,
            'update_at' => $this->update_at,
        ]);

        $query->andFilterWhere(['like', 'img', $this->img])
            ->andFilterWhere(['like', 'url', $this->url])
               ->andFilterWhere(['like', 'weight', $this->weight])
                  ->andFilterWhere(['like', 'display', $this->display])
                  ->andFilterWhere(['like', 'name', $this->name]);

        return $dataProvider;
    }
}
