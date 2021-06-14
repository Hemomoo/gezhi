<template>
 <div class="today">
      <div class="hearder">
        <p class="fwb f26 tal">2021年12月3日</p>
        <p class="tal">今天过得怎么样</p>
      </div>
     <section class="content f fjb" >
       <div class="left">
         <!-- 日期 -->
          <div class="date">
            <div>
              
            </div>
            <div></div>
          </div>
       </div>
       <div class="right">
         <Statistics></Statistics>
       </div>
     </section>
 </div>
</template>

<script>
import Statistics from './components/Statistics'
 export default {
   name:'Today',
   data () {
     return {

     }
   },
   components: {
     Statistics
   },
   setup(){

   }
 }
</script>

<style lang ='scss' scpoed>
.today{
  width: 80%;
  margin: 0 auto;
  .right{
    
    width: 30%;
  }
}
 
</style>
