<template>
	<view class="s-page-wrapper">
		<view class="s-page has-pd-20">
			<view class="has-mgt-35">
				<view class="is-size-25 has-title-color is-bold">
					高校师生通讯录
				</view>
				<view class="has-desc-color  has-mgt-20  is-bold">您的身份是？</view>
				<view class="is-block has-mgt-60 has-mgb-15">
					<navigator url="/pages/ucenter/stulogin">
						<view>
							<view class="is-block">
								<image src="../../static/img/common/student.jpg" class="is-response" mode="widthFix"></image>
							</view>
						</view>
					</navigator>
					<navigator url="/pages/ucenter/tealogin">
						<view class="has-mgt-30">
							<view class="is-block">
								<image src="../../static/img/common/teacher.jpg" class="is-response" mode="widthFix"></image>
							</view>
						</view>
					</navigator>

				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				title: 'Hello'
			}
		},
		onLoad() {

		},
		methods: {

		}
	}
</script>

<style>
</style>
