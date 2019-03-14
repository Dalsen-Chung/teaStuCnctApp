<template>
	<view class="uni-padding-wrap uni-common-mt">
		<form @submit="formSubmit">
			<view class="uni-form-item uni-column">
				<view class="title">输入反馈内容</view>
				<view class="uni-textarea">
					<textarea placeholder="请输入反馈内容" name="feedback" maxlength="-1" :auto-height="true" />
				</view>
			</view>
			<view class="uni-btn-v">
				<button formType="submit" type="primary">提交反馈</button>
			</view>
		</form>
	</view>
</template>
<script>
	export default {
		data() {
			return {
			}
		},
		methods: {
			formSubmit: function(e) {
				uni.showLoading({
					title: '加载中'
				});				
				let formData = e.detail.value
				if (formData.feedback.length === 0) {
					uni.showToast({
						title: '请填写反馈内容',
						icon: 'none'
					})
					return
				}
				uni.getStorage({
					key: 'userInfo',
					success: function(res) {
						let userInfo = res.data
						let param = {
							fedb_user_name: userInfo.stu_name ? userInfo.stu_name : userInfo.tea_name,
							fedb_content: formData.feedback,
						}
						uni.request({
							url: 'http://localhost/stuTeaCtct/index.php/app/feedback/saveFeedback',
							method:'POST',
							data: param,
							header: {
								'content-type' : 'application/x-www-form-urlencoded'
							},
							success: (res) => {
								if (res.data) {
									uni.hideLoading();
									uni.showToast({
										title: '提交反馈成功',
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
