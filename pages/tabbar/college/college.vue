<template>
	<view class="college">
		<view class="uni-page-head">
			<view class="uni-page-head-title">院系机构</view>
		</view>
		<uni-list>
			<uni-list-item v-for="(college, index) in collegeArr" :key="index" 
				:title="college.college_name" :note="college.college_introduction"
			 :thumb="collegeImgUrl + college.college_icon" @click="clickCollege(college)" ></uni-list-item>
		</uni-list>
		<view class="uni-page-head">
			<view class="uni-page-head-title">学术机构</view>
		</view>
		<uni-list>
			<uni-list-item v-for="(branch,index) in branchArr" :key="index" 
				:title="branch.edu_branch_name"  :note="branch.edu_branch_introduction" 
				@click="clickBranch(branch)"></uni-list-item>
		</uni-list>
	</view>
</template>

<script>
	import uniList from '@/components/uni-list/uni-list.vue'
	import uniListItem from '@/components/uni-list-item/uni-list-item.vue'
	export default {
		name: 'college',
		components:{uniList,uniListItem},
		data() {
			return {
				collegeArr: [],
				branchArr: [],
				collegeImgUrl : 'http://localhost/stuTeaCtct/public/common/image/college/'
			}
		},
		onLoad() {

		},
		methods: {
			getCollege() {
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/college/getCollege',
					method:'GET',
					data: {},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.collegeArr = res.data
					}
				});
			},
			getBranch() {
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/eduBranch/getEduBranch',
					method:'POST',
					data: {},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.branchArr = res.data
					}
				});
			},
			clickCollege(obj) {
				uni.navigateTo({
					url:'college-detail?address='+obj.college_address+'&icon='+obj.college_icon+'&id='+obj.college_id+'&intro='+obj.college_introduction+'&name='+obj.college_name
				})
			},
			clickBranch(obj) {
				uni.navigateTo({
					url:'branch-detail?id='+obj.edu_branch_id+'&address='+obj.edu_branch_address+'&intro='+obj.edu_branch_introduction+'&name='+obj.edu_branch_name
				})
			}
		},
		onLoad() {
			this.getCollege()
			this.getBranch()
		},
		onPullDownRefresh() {
			this.getCollege()
			this.getBranch()
			setTimeout(function () {
				uni.stopPullDownRefresh();
			}, 1000);
		}
	}
</script>

<style>
	page {
		background-color: #F0F0F0;
	}
</style>
