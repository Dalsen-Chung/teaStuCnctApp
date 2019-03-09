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
				contactObj:{}
			}
		},
		methods : {
			paramClick (e) {
				uni.redirectTo({
					url: '/pages/select-tab-detail/msg-apply/msg-apply?name='+e.name+'&id='+e.id
				});
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
			}
		},
		onLoad(option) {
			this.collegeId = option.collegeId
			this.majorId = option.majorId
			if (option.roleId == 2){	//学生
				this.getStudentByCM()
			} else if (option.roleId == 3) {	//教师
				this.getTeacherByCM()
			}
		}
	}
</script>

<style>

</style>
