<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\Slide;

/**
 * SlideSearch represents the model behind the search form about `common\models\Slide`.
 */
class SlideSearch extends Slide {

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['id', 'weight', 'create_at', 'update_at', 'display'], 'integer'],
            [['title', 'img', 'url'], 'safe'],
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
        $query = Slide::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'sort' => [
                'defaultOrder' => ['weight' => SORT_DESC],
                'attributes' => ['id', 'weight', 'display'],
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
            'weight' => $this->weight,
            'display' => $this->display,
            'create_at' => $this->create_at,
            'update_at' => $this->update_at,
        ]);

        $query->andFilterWhere(['like', 'title', $this->title])
                ->andFilterWhere(['like', 'img', $this->img])
                ->andFilterWhere(['like', 'url', $this->url]);

        return $dataProvider;
    }

}
