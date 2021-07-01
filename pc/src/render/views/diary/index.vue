<template>
  <div class="diary">
    <template v-for="(item, index) in diaryList" :key="index">
      <div class="diary-item tac"  v-if="index === 4">
        
        {{today}}
        
      </div>


      <router-link class="diary-item" to="/edit-diary" tag="div">
        <div class="tac">{{ item.tit }}</div>
        <div class="conten">
          {{ item.content }}
        </div>
      </router-link>
    </template>
  </div>
</template>

<script lang="ts">
import { reactive, toRefs, ref,defineComponent} from "vue";
import  moment  from "moment";
//定义ts数据类型
interface dataProps {}


interface Day {
  tit:string,
  id:string,
  content:string
}

// reactiveDate 接口
interface ReactiveData {

}


export default defineComponent ({
  name: "Diary",
  //import引入的组件需要注入到对象中才能使用
  components: {},
  //这里存放数据
  setup() {
    const data = reactive({});
    const today:string = moment().format('YYYY-MM-DD'); 
    const diaryList:Array<Day> = [
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
      {
        tit: "tit1",
        id: "23",
        content: "內容1",
      },
    ];
    return {
      data,
      diaryList,
      today
    };
  },
}) 
</script>

<style lang="scss" scoped>
.diary {
  height: 100vh;
  width: calc(100vw - 240px);
  display: grid;
  grid-template-columns: repeat(3, 33.33%);
  grid-template-rows: repeat(3, 33.33%);
  &-item {
    border-bottom: 1px solid gray;
    border-right: 1px solid gray;
    &:hover {
      background: gray;
    }
  }
}
</style>
