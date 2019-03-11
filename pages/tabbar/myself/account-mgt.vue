<template>
	<view class="accountMgt">
		<view class="uni-page-head">
			<view class="uni-page-head-title">账户设置</view>
		</view>
		<view class="uni-form-item uni-column">
			<view class="title">账号</view>
			<input class="uni-input" name="account" :value="userInfo.stu_account ? userInfo.stu_account : userInfo.tea_account" :disabled="true" />
		</view>
		<view class="uni-form-item uni-column">
			<view class="title">手机号</view>
			<input class="uni-input" name="phone" :value="userInfo.stu_phone ? userInfo.stu_phone : userInfo.tea_phone" />
		</view>
        <view class="uni-list is-mgt-15">
            <view class="uni-list-cell uni-list-cell-pd">
                <view class="uni-list-cell-db">{{switchTipsText}}</view>
                <switch :checked="canModifyPassWord" color="#09BB07" @change="switchChange" />
            </view>
        </view>
		<view class="uni-form-item uni-column" v-if="canModifyPassWord">
			<view class="title">旧密码</view>
			<input class="uni-input" name="oldPassword" type="password" placeholder="请输入旧密码" :value="oldPassword" />
		</view>
		<view class="uni-form-item uni-column" v-if="canModifyPassWord">
			<view class="title">新密码</view>
			<input class="uni-input" name="newPassword" type="password" placeholder="请输入新密码" :value="newPassword" />
		</view>
		<button type="primary" @click="saveInfo" class="is-mgt-20">保存设置</button>
		<view class="uni-page-head">
			<view class="uni-page-head-title">账户操作</view>
		</view>
		<button type="warn" @click="logout">退出登录</button>
	</view>
</template>

<script>
	export default {
		name: 'accountMgt',
		data() {
			return {
				userInfo: {},
				canModifyPassWord: false,
				switchTipsText: '关闭密码修改',
				oldPassword: '',
				newPassword: ''
			}
		},
		methods: {
			getMyInfo() {
				let that = this
				uni.getStorage({
					key: 'userInfo',
					success: function(res) {
						let userInfo = res.data
						that.userInfo = userInfo
						console.log(that.userInfo)
					},
				})
			},
			switchChange(val) {
				let statu = val.detail.value
				this.canModifyPassWord = statu
				if (statu)
					this.switchTipsText = '开启密码修改'
				else
					this.switchTipsText = '关闭密码修改'
			},
			saveInfo() {
				
			},
			logout() {
				uni.showModal({
					title: '确认',
					content: '确认退出当前用户？',
					success: function (res) {
						if (res.confirm) {
							uni.removeStorage({
								key: 'userInfo',
								success: function (res) {
									uni.reLaunch({
										url: '/pages/index/index'
									})
								}
							});
						}
					}
				})
			}
		},
		onLoad() {
			this.getMyInfo()
		}
	}
</script>

<style>
	page {
		background-color: #F0F0F0;
	}
	.accountMgt {
		padding: 0 40rpx;
	}
	.is-mgt-20 {
		margin-top: 40rpx;
	}
	.is-mgt-15 {
		margin-top: 30rpx;
	}
</style>
