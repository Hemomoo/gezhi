<template>
 <Calendar :events="events"></Calendar>
</template>

<script>
import Calendar from '@/views/calendar/components/Calendar-slider.vue'
 export default {
   name:'',
   data () {
     return {
            events: [
                {
                    date: '2018-11-22',
                    number: 100
                },
                {
                    date: '2018-11-25',
                    number: 2
                }
            ]
        }
   },
   components: {
     Calendar
   },
   methods: {
        monthChangedHandle (currentMonth) {
            setTimeout(()=>{
                this.events = [
                    {
                        date: '2018-12-22',
                        number: 2
                    },
                    {
                        date: '2020-12-26',
                        number: 2
                    }
                ]
            }, 100)
        },

        dateClickHandle (date) {
            console.log(date);
        }


    }
 }
</script>

<style lange ='scss' scpoed>

 
</style>
