<template>
	<view class="uni-padding-wrap uni-common-mt">
		<form @submit="formSubmit">
			<view class="uni-form-item uni-column">
				<view class="title">公告标题</view>
				<input class="uni-input" name="title" placeholder="请输入标题" />
			</view>
			<view class="uni-form-item uni-column">
				<view class="title">公告内容</view>
				<view class="uni-textarea">
					<textarea placeholder="请输入内容" name="content" maxlength="-1" :auto-height="true" />
				</view>
			</view>
			<view class="uni-form-item uni-column">
				<view class="uni-title">公告范围</view>
				<view class="uni-list">
					<view class="uni-list-cell uni-list-cell-pd">
						<view class="uni-list-cell-db" v-if="isAllCollege">全校发送</view>
						<view class="uni-list-cell-db" v-if="!isAllCollege">指定学院发送</view>
						<switch :checked="isAllCollege" name="isAllCollege" @change="switchChange" />
					</view>
				</view>
			</view>
			<view class="uni-form-item uni-column" v-if="!isAllCollege">
				<view class="uni-title">选择可查看的学院</view>
				<view class="uni-list">
					<view class="uni-list-cell">
						<view class="uni-list-cell-left">
							当前选择
						</view>
						<view class="uni-list-cell-db">
							<picker @change="bindCollegePickerChange" :value="collegeIndex" 
								range-key="college_name" :range="collegeArr" name="collegeId">
								<view class="uni-input">{{collegeArr[collegeIndex].college_name}}</view>
							</picker>
						</view>
					</view>
				</view>
			</view>
			<view class="uni-form-item uni-column" v-if="!isAllCollege">
				<view class="uni-title">选择可查看的专业</view>
				<view class="uni-list">
					<view class="uni-list-cell">
						<view class="uni-list-cell-left">
							当前选择
						</view>
						<view class="uni-list-cell-db">
							<picker  @change="bindMajorPickerChange" :value="majorIndex" 
								:range="majorArr" range-key="major_name" name="majorId">
								<view class="uni-input">{{majorArr[majorIndex].major_name}}</view>
							</picker>
						</view>
					</view>
				</view>
			</view>
			<view class="uni-btn-v">
				<button formType="submit" type="primary">提交审核</button>
			</view>
		</form>
	</view>
</template>
<script>
	export default {
		data() {
			return {
				collegeArr: [],
				collegeIndex: 0,
				collegeId: '',
				majorArr: [],
				majorIndex: 0,
				majorId: '',
				isAllCollege: true
			}
		},
		methods: {
			formSubmit: function(e) {
				uni.showLoading({
					title: '加载中'
				});				
				let formData = e.detail.value
				uni.getStorage({
					key: 'userInfo',
					success: function(res) {
						let userInfo = res.data
						let param = {
							notice_tea_id: userInfo.tea_id,
							notice_title: formData.title,
							notice_content: formData.content,
							college_id: formData.collegeId,
							major_id: formData.majorId,
							notice_is_all: formData.isAllCollege ? 1 : 0
						}
						uni.request({
							url: 'http://localhost/stuTeaCtct/index.php/app/nt_mgt/save_notice',
							method:'POST',
							data: param,
							header: {
								'content-type' : 'application/x-www-form-urlencoded'
							},
							success: (res) => {
								if (res.data) {
									uni.hideLoading();
									uni.showToast({
										title: '提交审核成功',
										icon: 'success'
									});
									setTimeout(function () {
										uni.switchTab({
											url:'/pages/tabbar/home/home'
										})
									},2000)
								}
							}
						});	
					}
				})
			},
			bindCollegePickerChange: function(e) {
				this.collegeIndex = e.target.value
				this.getMajorByCollegeId()
			},
			bindMajorPickerChange: function (e) {
				console.log(e.target.value)
				this.majorIndex = e.target.value
			},
			switchChange: function (e) {
				this.isAllCollege = e.target.value
			},
			getCollege: function () {
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/college/getCollege',
					method:'POST',
					data: {},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.collegeArr = res.data
						this.getMajorByCollegeId()
					}
				});				
			},
			getMajorByCollegeId: function () {
				this.majorIndex = 0
				this.collegeId = this.collegeArr[this.collegeIndex].college_id
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
		onLoad: function () {
			this.getCollege()
		}
	}
</script>

<style scoped>
	.uni-form-item .title {
		padding: 20upx 0;
	}
	page {
		background-color: #F0F0F0;
	}
</style>
