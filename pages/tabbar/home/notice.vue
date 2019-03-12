<template>
	<view class="notice">
		<!-- 标题 -->
		<view :class="['grace-article-title','uni-center', graceSkeleton == 'ing' ? 'grace-skeleton' : '']">{{notice.notice_title}}</view>
		<!-- 作者信息 -->
		<view class="grace-article-author-line">
			<view :class="['grace-article-author', graceSkeleton == 'ing' ? 'grace-skeleton' : '']">
				<view class="author-name">作者 : {{notice.tea_name}}</view>
			</view>
		</view>
		<!-- 其他基本信息 -->
		<view :class="['grace-article-info-line', graceSkeleton == 'ing' ? 'grace-skeleton' : '']">
			<view>阅读次数 : {{notice.notice_read_times}}</view>
			<view>发布时间 : {{notice.notice_time}}</view>
		</view>
		<!-- 文章内容 -->
		<view class="grace-article-contents">
			<view :class="['text-item', graceSkeleton == 'ing' ? 'grace-skeleton' : '']" >{{notice.notice_content}}</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			graceSkeleton : 'ing',
			noticeId: '',
			notice: {}
		}
	},
	methods: {
		getNoticeById() {
			uni.request({
				url: 'http://localhost/stuTeaCtct/index.php/app/nt_mgt/get_notice_by_id',
				method:'POST',
				data: {
					notice_id: this.noticeId
				},
				header: {
					'content-type' : 'application/x-www-form-urlencoded'
				},
				success: (res) => {
					this.notice = res.data
					// console.log(this.notice)
				}
			})
		}
	},
	onLoad(option) {
		this.noticeId = option.noticeId
		this.getNoticeById()
	}
}
</script>
<style scoped>
	.notice-title {
		font-size: 40rpx !important;
		font-weight: 600;
		padding: 40rpx 20rpx;
	}
	.notice-info {
		padding: 0 40rpx;
	}
</style>
