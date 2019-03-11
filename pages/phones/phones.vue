<template>
	<view>
		<phone-directory :phones="contactObj" @paramClick="paramClick"></phone-directory>
	</view>
</template>

<script>
	import phoneDirectory from '@/components/phone-directory/phone-directory.vue'
	export default {
		name:"phones",
		components:{
			phoneDirectory
		},
		data() {
			return {
				//示例数据
				collegeId: '',
				majorId: '',
				contactObj:{},
				option: {},
				showInfo: true
			}
		},
		methods : {
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
			},
			getStudentByCM: function () {
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/student/getStudentByCM',
					method:'POST',
					data: {
						collegeId: this.collegeId,
						majorId: this.majorId
					},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.contactObj = res.data
					}
				});
			},
			getTeacherByCM: function () {
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/teacher/getTeacherByCM',
					method:'POST',
					data: {
						collegeId: this.collegeId,
						majorId: this.majorId
					},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.contactObj = res.data
					}
				});
			},
			requestByC() {
				let that = this
				uni.getStorage({
					key: 'userInfo',
					success: function(res) {
						let userInfo = res.data
						that.collegeId = userInfo.college_id
						that.majorId = ''
						if (userInfo.role_id == 2){	//学生
							that.getStudentByCM()
						} else if (userInfo.role_id == 3) {	//教师
							that.getTeacherByCM()
						}
					},
				})	
			}
		},
		onLoad(option) {
			this.option = option
			if (JSON.stringify(option) !== '{}') {
				this.collegeId = option.collegeId
				this.majorId = option.majorId
				this.showInfo = false
				if (option.roleId == 2){	//学生
					this.getStudentByCM()
				} else if (option.roleId == 3) {	//教师
					this.getTeacherByCM()
				}
			}
		},
		mounted() {
			if (JSON.stringify(this.option) === '{}'){
				this.requestByC()
				this.showInfo = true
			}
		}
	}
</script>

<style>

</style>
