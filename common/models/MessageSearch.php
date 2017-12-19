<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\Message;

/**
 * MessageSearch represents the model behind the search form about `common\models\Message`.
 */
class MessageSearch extends Message {

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['id', 'replyway', 'display', 'create_at'], 'integer'],
            [['theme', 'linkman', 'content', 'linkway','address','email'], 'safe'],
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
        $query = Message::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => ['pageSize' => 10],
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
            'replyway' => $this->replyway,
            'display' => $this->display,
            'create_at' => $this->create_at,
               'address' => $this->display,
            'email' => $this->create_at,
        ]);

        $query->andFilterWhere(['like', 'theme', $this->theme])
                ->andFilterWhere(['like', 'linkman', $this->linkman])
                ->andFilterWhere(['like', 'content', $this->content])
                ->andFilterWhere(['like', 'linkway', $this->linkway])
                 ->andFilterWhere(['like', 'address', $this->address])
                ->andFilterWhere(['like', 'email', $this->email]);

        return $dataProvider;
    }

}
