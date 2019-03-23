<template>
	<view>
		<phone-search-list :phones="phones" @paramClick="paramClick"></phone-search-list>
	</view>		
</template>

<script>
	
	import phoneSearchList from '@/components/phone-directory/phone-search-list.vue'
	
	export default {
		name:"phone-search",
		components:{
			phoneSearchList
		},
		data() {
			return {
				phones:null,
			}
		},
		onLoad (option) {
			this.phones = JSON.parse(unescape(option.phones))
		},
		methods:{
			paramClick (e) {
				if (this.showInfo) {
					uni.navigateTo({
						url: '/pages/self-info/self-info?id='+e.id+'&roleId='+e.roleid
					});
				} else {
					uni.redirectTo({
						url: '/pages/select-tab-detail/msg-apply/msg-apply?name='+e.name+'&id='+e.id+'&roleId='+e.roleid
					});
				}
			}
		}
	}
</script>

<style>
	
</style>
