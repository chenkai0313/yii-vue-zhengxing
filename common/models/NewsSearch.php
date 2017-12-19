<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\News;

/**
 * NewsSearch represents the model behind the search form about `common\models\News`.
 */
class NewsSearch extends News {

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['id', 'thumb', 'source', 'create_at', 'update_at', 'weight', 'pid', 'cid', 'display'], 'integer'],
            [['title', 'remark', 'content'], 'safe'],
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
        $query = News::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => ['pageSize' => 10],
            'sort' => [
                'defaultOrder' => ['weight' => SORT_DESC],
                'attributes' => ['id', 'weight', 'display', 'create_at'],
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
            'thumb' => $this->thumb,
            'source' => $this->source,
            'create_at' => $this->create_at,
            'update_at' => $this->update_at,
            'weight' => $this->weight,
            'display' => $this->display,
            'pid' => $this->pid,
            'cid' => $this->cid,
        ]);

        $query->andFilterWhere(['like', 'title', $this->title])
                ->andFilterWhere(['like', 'remark', $this->remark])
                ->andFilterWhere(['like', 'content', $this->content]);

        return $dataProvider;
    }

}
