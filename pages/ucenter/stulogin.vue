<template>
	<view class="s-page-wrapper">
		<HMmessages ref="HMmessages" @complete="HMmessages = $refs.HMmessages"></HMmessages>
		<view class="is-20vh has-pdt-60">
			<view class="is-flex is-column is-justify-center  is-align-center is-height-100">
				<image src="../../static/img/common/stu_login.png" mode="aspectFit" class="logoimg"></image>
			</view>
		</view>
		<view class="content">
			<view class="has-mglr-10 ">
				<view class=" has-mgtb-10 ">
					<input type="number" maxlength="11" v-model="login.studentAcc" placeholder="请输入学号" class="is-input1 " data-val="studentAcc" />
				</view>
				<view class=" has-radius has-mgtb-10">
					<input v-model="login.password" password="true" placeholder="请输入登录密码" class="is-input1"  data-val="password"/>
				</view>

				<view class=" loginbtn has-radius has-mgtb-20">
					<button :loading="login.loading" @tap="defaultHandlerLogin"> {{ login.loading ? "登录中...":"登 录"}} </button>
				</view>
			</view>
		</view>
		<view class="is-20vh has-mgt-80 content">
			<view class=" has-radius is-center is-size-14 is-grey has-mgr-20">
				<text>@中山大学南方学院</text>
			</view>
		</view>
	</view>
</template>

<script>
	import HMmessages from '@/components/HM-messages/HM-messages.vue'
	export default {
		name:"stuLogin",
		components:{HMmessages},
		data() {
			return {
				login: {
					loading: false,
					studentAcc:"",
					password:""
				},
				alertText: '',
				alertType: ''
			};
		},
		methods:{
			defaultHandlerLogin:function(){
				this.login.loading = true;
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/student/login',
					method:'POST',
					data: {
						"account": this.login.studentAcc,
						"password": this.login.password
					},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						if (res.data.resMsg === 'success') {
							this.alertText = '登录成功';
							this.alertType = 'success';
						} else if (res.data.resMsg === 'failed'){
							this.alertText = res.data.resBody;
							this.alertType = 'error';
						}
						this.login.loading = false;
						this.HMmessages.show(this.alertText,{icon: this.alertType});
						if (this.alertType === 'success') {
							let userInfo = Object.assign({}, res.data.resBody)
							userInfo.role = 'student'
							uni.setStorage({
								key: 'userInfo',
								data: userInfo,
								success() {
									setTimeout(function(){
										uni.switchTab({
											url:'/pages/tabbar/home/home'
										})
									},1000)
								}
							})
						}
					}
				});
			}
		}
	}
</script>

<style>
	page {
		min-height: 100%;
		background-color: #FFFFFF;
	}

	.content {
		width: 85%;
		margin: 0 auto;
	}

	.loginbtn button {
		margin-top: 20rpx;
		height: 88rpx;
		width: 100%;
		line-height: 88rpx;
		color: #ffffff;
		font-size: 32rpx;
		border-radius: 44rpx;
		outline: 0;
		display: block;
		margin: 0;
		font-family: inherit;
		background: #0E80D2;
		opacity: 0.8;
	}

	button:after {
		border: 2rpx solid #f2f2f2;
	}

	.logoimg {
		width: 200rpx;
		height: 200rpx;
		border-radius: 50%;
	}

	.is-input1 {
		height: 88rpx;
		width: 100%;
		line-height: 88rpx;
		padding: 12rpx;
		color: #353535;
		font-size: 32rpx;
		box-sizing: border-box;
		appearance: none;
		border: 2rpx solid #e5e5e5;
		box-shadow: none;
		border-radius: 44rpx;
		outline: 0;
		display: block;
		padding-left: 30rpx;
		margin: 0;
		font-family: inherit;
		background: #fff;
		resize: none;
	}
</style>
