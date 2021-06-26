<template>
    <div class="calendar">
        <div class="container">
            <div class="select">
                <i class="iconfont icon-arrow-left" @click="arrowChangeMonth(0)" v-if="!showMonth" :class="{disabled: this.showYear && this.currentCutYearsIndex === 0}"></i>
                <div class="select__wrapper year">
                    <div class="select__result" @click="handleSelectYear">{{ selectYear }}年</div>
                </div>
                <div class="select__wrapper month">
                    <div class="select__result" @click="showSelectPanel = true; showMonth = true; showYear = false">{{ selectMonth }}月</div>
                </div>
                <i class="iconfont icon-arrow-right" @click="arrowChangeMonth(1)" v-if="!showMonth" :class="{disabled: this.showYear && this.currentCutYearsIndex === this.cutYears.length - 1}"></i>
            </div>
            <div class="select-panel" v-show="showSelectPanel">
                <ul class="year" v-if="showYear">
                    <li v-for="item of displayYears" :key="item" :class="{active: item === selectYear}" @click="changeYear(item)">{{ item }}</li>
                </ul>
                <ul class="month" v-else>
                    <li v-for="item of 12" :key="item" :class="{active: item === selectMonth}" @click="changeMonth(item)">{{ item }}</li>
                </ul>
            </div>
            <dl v-show="!showSelectPanel">
                <dt>
                    <ol class="weekName">
                        <li v-for="item in ['日', '一', '二', '三', '四', '五', '六']" :key="item">{{ item }}</li>
                    </ol>
                </dt>
                <dd
                    v-for="(day, index) in dates"
                    :key="index"
                    :class="[
                        day.class,
                        day.isActive ? 'active' : '',
                        day.day === today && day.class === 'current-month' ? 'today' : ''
                    ]"
                    @click="handleDayClick(day, index)"
                >{{ day.day }}
                </dd>
            </dl>
        </div>

        <h4>当前选择的日期为：{{ selectYear }}年{{ selectMonth }}月{{ selectDay }}日</h4>
    </div>
</template>

<script>
    export default {
        name: 'Calendar',
        data() {
            return {
                monthList: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                yearList: [],
                selectMonth: 1,
                selectYear: 2014,
                selectDay: new Date().getDate(),
                dates: [],
                showMonth: false, // 显示月份选择
                showYear: false,
                today: new Date().getDate(),
                showSelectPanel: false, // 显示年月选择面板
                cutYears: [], // 分割后的年份数组
                currentCutYearsIndex: 0
            }
        },
        computed: {
            // 显示的年份数组，用来在年份选择面板展示
            displayYears() {
                return this.cutYears[this.currentCutYearsIndex]
            }
        },
        mounted() {
            this.createYear()
        },
        methods: {
            // 创建年份数组
            createYear() {
                let arr = [];
                let curYear = new Date().getFullYear()
                for (let i = 1900; i <= curYear; i++) {
                    arr.push(i)
                }
                this.yearList = arr
                this.selectYear = curYear

                // 赋值分割后的年份数组
                for (let i = 0; i < arr.length; i += 12 ) {
                    this.cutYears.push(arr.slice(i, i + 12))
                }

                this.currentCutYearsIndex = this.cutYears.findIndex(cur => cur.includes(curYear))
            },

            createCalendar() {
                let days = new Date(this.selectYear, this.selectMonth, 0).getDate(); // 当月天数
                let firstDay = new Date(this.selectYear, this.selectMonth - 1, 1).getDay(); // 当月第一天的星期
                this.dates = [];

                // 如果当月第一天不是周日，则在前面填充上个月的日期
                if (firstDay > 0) {
                    let lastMonthDays = new Date(this.selectYear, this.selectMonth - 1, 0).getDate(); // 上个月总天数

                    for (let i = lastMonthDays - firstDay + 1; i <= lastMonthDays ; i++) {
                        this.dates.push({
                            day: i,
                            class: "last-month",
                            isActive: false
                        })
                    }
                }

                for (let i = 1; i <= days; i++) {
                    this.dates.push({
                        day: i,
                        class: "current-month",
                        isActive: false
                    });
                }

                // 填充下个月
                let nextDays = 7 - this.dates.length % 7
                if (nextDays < 7 && nextDays > 0) {
                    let day = 0;
                    for (let i = 0; i < nextDays; i++) {
                        this.dates.push({
                            day: ++day,
                            class: "next-month",
                            isActive: false
                        })
                    }
                }

            },

            // 选择年份
            handleSelectYear() {
                this.currentCutYearsIndex = this.cutYears.findIndex(cur => cur.includes(this.selectYear))
                this.showSelectPanel = true; this.showYear = true; this.showMonth = false
            },

            // 日期点击事件
            handleDayClick(day, index) {
                if (day.class !== 'current-month') return

                this.dates.forEach((cur, index2) => {
                    if (index === index2) {
                        cur.isActive = true;
                    } else {
                        cur.isActive = false;
                    }
                })

                this.selectDay = day.day
            },

            // 改变月
            changeMonth(month) {
                this.selectMonth = month
                this.showSelectPanel = false
                this.showMonth = false
                this.createCalendar()
            },

            /**
             * 通过点击箭头切换月份
             * @param { number } method 0.上个月 1.下个月
             */
            arrowChangeMonth(method) {
                // 如果打开了选择年月面板，则切换年份
                if (this.showSelectPanel) {
                    if ((method === 0 && this.currentCutYearsIndex === 0) || (method === 1 && this.currentCutYearsIndex === this.cutYears.length - 1)) return

                    method === 0 ? this.currentCutYearsIndex-- : this.currentCutYearsIndex++
                    return
                }

                if (method === 0) {
                    if (this.selectMonth === 1) {
                        this.selectYear--
                        this.changeMonth(12)
                    } else {
                        this.changeMonth(this.selectMonth - 1)
                    }
                } else {
                    if (this.selectMonth === 12) {
                        this.selectYear++
                        this.changeMonth(1)
                    } else {
                        this.changeMonth(this.selectMonth + 1)
                    }
                }
            },

            // 改变年
            changeYear(year) {
                this.selectYear = year
                this.showYear = false
                this.createCalendar()
            }
        },
        created() {
            let date = new Date();
            this.selectMonth = date.getMonth() + 1;
            this.selectYear = date.getFullYear();

            this.createCalendar();
        }
    }
</script>

<style scoped lang="scss">
    .calendar {
        $itemWidth: 40px;

        user-select: none;

        .container {
            padding: 20px;
            box-shadow: 0 0 3px rgba(0, 0, 0, .2);
        }

        &__wrapper {
            td, th {
                width: $itemWidth;
                height: $itemWidth;
                text-align: center;
            }

            td {
                border: 1px solid #000;
            }
        }

        dl {
            width: $itemWidth * 7;
        }

        dd {
            position: relative;
            display: inline-block;
            width: $itemWidth;
            height: $itemWidth;
            text-align: center;
            line-height: $itemWidth;
            cursor: pointer;

            &.last-month,
            &.next-month {
                color: #bbbbbb;
            }

            &::after {
                content: "";
                display: block;
                position: absolute;
                z-index: -1;
                top: 50%;
                left: 50%;
                width: 80%;
                height: 80%;
                margin: -40% 0 0 -40%;
                border-radius: 50%;
                background-color: transparent;
            }

            &:hover::after {
                background-color: #dedede;
            }

            &.active {
                color: #fff;

                &::after {
                    background-color: deepskyblue;
                }

                &.today {
                    color: #fff;
                }
            }

            &.today {
                color: deepskyblue;
            }
        }

        .weekName {
            display: flex;

            li {
                width: $itemWidth;
                height: $itemWidth;
                text-align: center;
                line-height: $itemWidth;
            }
        }
    }

    .container {
        width: fit-content;
        margin: 20vh auto 0;
    }

    .select {
        display: flex;
        align-items: center;
        justify-content: center;

        i {
            cursor: pointer;

            &:active {
                color: deepskyblue;
            }

            &.disabled {
                cursor: not-allowed;
                color: #bbbbbb;
            }
        }

        .icon-arrow-left {
            margin-right: auto;
        }

        .icon-arrow-right {
            margin-left: auto;
        }
    }

    /*.select__wrapper {
        position: relative;
        width: 80px;

        .select__result {
            position: relative;
            padding: 5px 30px 5px 10px;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            cursor: pointer;

            &::after {
                content: "\25BE";
                position: absolute;
                top: 3px;
                right: 0;
                vertical-align: middle;
                line-height: 1;
                font-size: 26px;
                font-weight: bold;
                color: #555555;
                transition: transform .3s;
            }
        }

        .select__dropdown {
            position: absolute;
            z-index: 2;
            width: 100%;
            height: 0;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0, 0, 0, .1);
            overflow: hidden;
            transition: height .3s;

            &__item {
                height: 30px;
                line-height: 30px;
                padding: 0 5px;

                &.active {
                    background: deepskyblue;
                    color: #fff;
                }

                &:hover {
                    background: deepskyblue;
                    color: #fff;
                }
            }
        }

        &.active {
            .select__result::after {
                transform: rotate(180deg);
            }

            .select__dropdown {
                height: 360px;
            }
        }

        &--year {
            width: 100px;
            margin-right: 20px;

            &.active .select__dropdown {
                height: 300px;
            }
        }
    }*/
    .select__wrapper {
        cursor: pointer;

        &:hover {
            color: #00bfff;
        }

        &.month {
            margin-left: 10px;
        }
    }

    .select-panel {
        width: 280px;
        height: 240px;

        ul {
            display: flex;
            flex-wrap: wrap;

            li {
                width: 25%;
                height: 80px;
                line-height: 80px;
                text-align: center;
                cursor: pointer;

                &:hover,
                &.active {
                    color: deepskyblue;
                }
            }
        }
    }
</style>