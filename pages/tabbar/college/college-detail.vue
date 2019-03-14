<template>
	<view class="collegeInfo">
		<view class="has-pd-20">
			<view class="is-flex  is-justify-center">
				<image :src="collegeImgUrl + icon" mode="aspectFit" class="logoimg"></image>
			</view>
		</view>
		<view class="uni-form-item uni-column">
			<view class="title"><uni-tag text="学院地址"  size="small" type="primary"></uni-tag></view>
			<input class="uni-input"  :value="address" disabled="disabled" />
		</view>
		<view class="uni-form-item uni-column">
			<view class="title"><uni-tag text="学院简介"  size="small" type="primary"></uni-tag></view>
			<view class="uni-textarea">
				<textarea :value="intro" maxlength="-1" :auto-height="true" :disabled="true" />
			</view>
		</view>
		<view class="uni-page-head">
			<view class="uni-page-head-title">所有专业</view>
		</view>
		<uni-collapse accordion="true">
			<uni-collapse-item v-for="(major,index) in majorArr" :key="index" :title="major.major_name">
				<view style="padding: 30upx;">
					<view class="">
						<uni-tag text="简介" size="small" type="success"></uni-tag>
					</view>
					{{major.major_introduction}}
				</view>
			</uni-collapse-item>
		</uni-collapse>
	</view>
</template>

<script>
import uniCollapse from '@/components/uni-collapse/uni-collapse.vue'
import uniCollapseItem from '@/components/uni-collapse-item/uni-collapse-item.vue'
import uniTag from "@/components/uni-tag/uni-tag.vue"
export default {
	name: 'college-detail',
	components:{uniCollapse,uniCollapseItem,uniTag},
	data() {
		return {
			collegeImgUrl : 'http://localhost/stuTeaCtct/public/common/image/college/',
			address: '',
			icon: '',
			collegeId: '',
			intro: '',
			collegeName: '',
			majorArr: []
		}
	},
	methods: {
		getMajorByCollegeId: function () {
			uni.request({
				url: 'http://localhost/stuTeaCtct/index.php/app/major/getMajorByCollege',
				method:'POST',
				data: {
					collegeId : this.collegeId
				},
				header: {
					'content-type' : 'application/x-www-form-urlencoded'
				},
				success: (res) => {
					this.majorArr = res.data
				}
			});				
		}
	},
	onLoad(option) {
		this.address = option.address
		this.icon = option.icon
		this.collegeId = option.id
		this.intro = option.intro
		this.collegeName = option.name
		uni.setNavigationBarTitle({
			title: this.collegeName
		})
		this.getMajorByCollegeId()
	},
}
</script>

<style scoped>
	page {
		background-color: #F0F0F0;
	}
	.has-pd-20 {
		padding: 40rpx 0;
	}
	.logoimg {
		width: 200rpx;
		height: 200rpx;
		border-radius: 50%;
	}
	.is-width-80 {
		width: 80%;
	}
</style>
