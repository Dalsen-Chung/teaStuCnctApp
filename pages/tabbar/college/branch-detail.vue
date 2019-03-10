<template>
	<view class="branch-detail">
		<view class="has-pd-20">
			<view class="is-flex  is-justify-center">
				<image src="../../../static/img/common/school.png" mode="aspectFit" class="logoimg"></image>
			</view>
		</view>
		<view class="uni-form-item uni-column">
			<view class="title"><uni-tag text="机构地址"  size="small" type="primary"></uni-tag></view>
			<input class="uni-input"  :value="address" disabled="disabled" />
		</view>
		<view class="uni-form-item uni-column">
			<view class="title"><uni-tag text="机构简介"  size="small" type="primary"></uni-tag></view>
			<view class="uni-textarea">
				<textarea :value="intro" maxlength="-1" :auto-height="false" :disabled="true" />
			</view>
		</view>
	</view>
</template>

<script>
import uniTag from "@/components/uni-tag/uni-tag.vue"
export default {
	name: 'branch-detail',
	components:{uniTag},
	data() {
		return {
			address: '',
			intro: '',
			branchName: ''
		}
	},
	methods: {
	},
	onLoad(option) {
		this.address = option.address
		this.intro = option.intro
		this.branchName = option.name
		uni.setNavigationBarTitle({
			title: this.branchName
		})
	},
}
</script>

<style>
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
</style>
