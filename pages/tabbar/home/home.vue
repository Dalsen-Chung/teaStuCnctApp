<template>
	<view class="home">
        <uni-segmented-control :current="current" :values="items" @clickItem="onClickItem" style-type="button" active-color="#1E90FF"></uni-segmented-control>
        <view class="content">
            <view v-show="current === 0">
				<uni-list>
					<uni-list-item v-for="(notice,index) in noticeArr" :key="index" 
						:title="notice.notice_title"  :note="'发布于：'+notice.notice_time" 
						@click="clickNotice(notice)" 
						v-if="nowRoleId ==='3' || notice.college_id === nowCollegeId || notice.notice_is_all === '1'"></uni-list-item>
				</uni-list>
            </view>
            <view v-show="current === 1">
				<uni-card 
					v-for="(apply,index) in applyArr"
					:key="index"
					:title="apply.apply_time" 
					thumbnail="../../../static/img/common/time.png">
					<view class="uni-text">
						被查看用户：{{apply.check_user_id}}
					</view>
					<view class="uni-text">
						被查看用户类型：{{apply.check_user_type}}
					</view>
					<view class="uni-text">
						申请理由：{{apply.apply_reason}}
					</view>
					<view class="uni-text">
						申请进度：
						<uni-tag size="small" text="待审核" type="warning" v-if="apply.apply_result == 0"></uni-tag>
						<uni-tag size="small" text="审核通过,点击查看" type="success" v-if="apply.apply_result == 1" @click="lookAtInfo(apply)"></uni-tag>
						<uni-tag size="small" text="审核不通过" type="error" v-if="apply.apply_result == 2"></uni-tag>
					</view>
				</uni-card>
            </view>
        </view>
	</view>
</template>
<script>
import uniSegmentedControl from "@/components/uni-segmented-control/uni-segmented-control.vue"
import uniList from '@/components/uni-list/uni-list.vue'
import uniListItem from '@/components/uni-list-item/uni-list-item.vue'
import uniCard from "@/components/uni-card/uni-card.vue"
import uniTag from "@/components/uni-tag/uni-tag.vue"
export default {
    components: {uniSegmentedControl,uniList,uniListItem,uniCard,uniTag},
    data() {
        return {
            items: ['公告','信息工单'],
            current: 0,
			noticeArr: [],
			applyArr: [],
			nowCollegeId: '',
			nowRoleId: '',
			myId: ''
        }
    },
    methods: {
        onClickItem(index) {
            if (this.current !== index) {
                this.current = index;
            }
        },
		getNotice() {
			uni.request({
				url: 'http://localhost/stuTeaCtct/index.php/app/nt_mgt/get_notice',
				method:'POST',
				data: {},
				header: {
					'content-type' : 'application/x-www-form-urlencoded'
				},
				success: (res) => {
					this.noticeArr = res.data
				}
			})		
		},
		getApplyList() {
			uni.request({
				url: 'http://localhost/stuTeaCtct/index.php/app/apply/getApply',
				method:'POST',
				data: {
					apply_user_id: this.myId,
					apply_user_type: this.nowRoleId
				},
				header: {
					'content-type' : 'application/x-www-form-urlencoded'
				},
				success: (res) => {
					this.applyArr = res.data
				}
			})
		},
		clickNotice(notice) {
			uni.navigateTo({
				url: 'notice?noticeId=' + notice.notice_id
			})
		},
		getMyInfo() {
			let that = this
			uni.getStorage({
				key: 'userInfo',
				success: function(res) {
					let userInfo = res.data
					that.nowCollegeId = userInfo.college_id
					that.nowRoleId = userInfo.role_id
					that.myId = userInfo.stu_id ? userInfo.stu_id : userInfo.tea_id
				}
			})
		},
		lookAtInfo(apply) {
			uni.navigateTo({
				url: '/pages/self-info/self-info?id='+apply.check_user_id+'&roleId='+apply.check_user_type+'&showAddress=true'
			})
		}
    },
	onLoad() {
		this.getNotice()
		this.getMyInfo()
		this.getApplyList()
	}
}
</script>
<style>
/* 	page {
		background-color: #F0F0F0;
	} */
	.home{
		padding-top: 35rpx;
	}
	.home .content {
		margin-top: 35rpx;
	}
</style>