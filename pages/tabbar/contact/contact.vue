<template>
	<view class="content">
		<contact-list></contact-list>
	</view>
</template>

<script>
	import contactList from '@/pages/phones/phones'
	export default {
		name: 'contact',
		components:{contactList},
		data() {
			return {
			}
		},
		methods: {
		},
		onLoad() {
		}
	}
</script>

<style>
</style>
