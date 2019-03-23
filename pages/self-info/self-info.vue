<template>
	<view class="infoContent">
		<view class="has-pd-20">
			<view class="is-flex  is-justify-center" v-if="roleId==='2'">
				<image src="../../static/img/common/stu_user.png" mode="aspectFit" class="logoimg"></image>
			</view>
			<view class="is-flex  is-justify-center" v-if="roleId==='3' && sexy==='男'">
				<image src="../../static/img/common/tea_boy.png" mode="aspectFit" class="logoimg"></image>
			</view>
			<view class="is-flex  is-justify-center" v-if="roleId==='3' && sexy==='女'">
				<image src="../../static/img/common/tea_girl.png" mode="aspectFit" class="logoimg"></image>
			</view>
		</view>
		<view class="has-pdb-15">
			<uni-card 
				title="姓名"
				thumbnail="../../static/img/selfInfo/name.png">
				<view class="uni-center">
					{{info.stu_name ? info.stu_name : info.tea_name}}
				</view>
			</uni-card>
			<uni-card 
				title="性别"
				v-if="roleId==='2'"
				thumbnail="../../static/img/selfInfo/sex.png">
				<view class="uni-center">
					{{info.stu_sex ? info.stu_sex : info.tea_sex}}
				</view>
			</uni-card>
			<uni-card 
				title="年级"
				v-if="roleId==='2'"
				thumbnail="../../static/img/selfInfo/grade.png">
				<view class="uni-center">
					{{info.stu_grade}}
				</view>
			</uni-card>
			<uni-card 
				title="所属学院" 
				thumbnail="../../static/img/selfInfo/college.png">
				<view class="uni-center">
					{{info.college_name}}
				</view>
			</uni-card>
			<uni-card 
				title="所属专业" 
				thumbnail="../../static/img/selfInfo/major.png">
				<view class="uni-center">
					{{info.major_name}}
				</view>
			</uni-card>
			<uni-card 
				title="班级"
				v-if="roleId==='2'"
				thumbnail="../../static/img/selfInfo/class.png">
				<view class="uni-center">
					{{info.stu_class}}
				</view>
			</uni-card>
			<uni-card 
				title="电话" 
				thumbnail="../../static/img/selfInfo/phone.png">
				<view class="uni-center">
					{{info.stu_phone ? info.stu_phone :info.tea_phone}}
				</view>
			</uni-card>
			<uni-card v-if="roleId === '3'"
				title="教授课程" 
				thumbnail="../../static/img/selfInfo/course.png">
				<view class="uni-center">
					<uni-tag size="small" v-for="(course,index) in courseArr" 
					:key="index" :text="course" type="success" class="courseTag"></uni-tag>
				</view>
			</uni-card>
			<uni-card v-if="roleId === '3'"
				title="是否为辅导员" 
				thumbnail="../../static/img/selfInfo/if.png">
				<view class="uni-center">
					<uni-tag size="small" :text="info.tea_isInstructor == 1 ? '是' : '否'" type="primary"></uni-tag>
				</view>
			</uni-card>
			<uni-card 
				title="家庭住址"
				v-if="roleId==='2'"
				thumbnail="../../static/img/selfInfo/address.png">
				<view class="uni-form-item uni-column" v-if="showStuAddress === false">
					<view class="title">申请理由</view>
					<view class="uni-input">
						<input type="text" name="applyReason" v-model="applyReason" placeholder="请输入理由" />
					</view>
					<view class="uni-center">
						<uni-tag text="点击申请查看" type="success" @click="applyMsg"></uni-tag>
					</view>
				</view>
				<view class="uni-textarea" v-if="showStuAddress === true">
					<textarea name="applyReason" maxlength="-1" v-model="info.stu_address" :disabled="true" />
				</view>
			</uni-card>
		</view>
	</view>
</template>

<script>
	import uniCard from "@/components/uni-card/uni-card.vue"
	import uniTag from "@/components/uni-tag/uni-tag.vue"
	export default {
		name: 'selfInfo',
		components:{uniCard,uniTag},
		data() {
			return {
				userId: '',
				roleId: '',
				sexy: '',
				info: {},
				courseArr: [],
				applyReason: '',
				showStuAddress: false
			}
		},
		methods: {
			getSelfInfo() {
				let requestPath = ''
				if (this.roleId === '2') {
					requestPath = 'http://localhost/stuTeaCtct/index.php/app/student/getStudentById'
				} else if (this.roleId === '3') {
					requestPath = 'http://localhost/stuTeaCtct/index.php/app/teacher/getTeacherById'
				}
				uni.request({
					url: requestPath,
					method:'POST',
					data: {
						user_id: this.userId
					},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.info = res.data
						this.sexy = this.info.stu_sex ? this.info.stu_sex : this.info.tea_sex
						if (this.info.tea_course) {
							this.courseArr = this.info.tea_course.split(',')
						}
						console.log(this.info)
					}
				});
			},
			applyMsg() {
				if (this.applyReason.length === 0) {
					uni.showToast({
						title: '请输入申请理由',
						icon:'none'
					})
					return
				}
				let that = this
				uni.showLoading({
					title: '提交中'
				});				
				uni.getStorage({
					key: 'userInfo',
					success: function(res) {
						let userInfo = res.data
						let param = {
							apply_reason: that.applyReason,
							apply_user_id: userInfo.stu_id ? userInfo.stu_id : userInfo.tea_id,
							apply_user_type: userInfo.role_id,
							apply_user_name: userInfo.stu_name ? userInfo.stu_name : userInfo.tea_name,
							check_user_id: that.info.stu_id,
							check_user_type: that.info.role_id,
							check_user_name: that.info.stu_name
						}
						uni.request({
							url: 'http://localhost/stuTeaCtct/index.php/app/apply/saveApply',
							method:'POST',
							data: param,
							header: {
								'content-type' : 'application/x-www-form-urlencoded'
							},
							success: (res) => {
								if (res.data) {
									uni.hideLoading();
									uni.showToast({
										title: '提交申请成功',
										icon: 'success'
									});
									setTimeout(function () {
										uni.switchTab({
											url:'/pages/tabbar/home/home?refresh=true'
										})
									},2000)
								}
							}
						});	
					}
				})
			}
		},
		onLoad(option) {
			if (JSON.stringify(option) !== '{}') {
				this.userId = option.id
				this.roleId = option.roleId
				this.getSelfInfo()
				this.showStuAddress = option.showAddress ? true : false
			}
		}
	}
</script>

<style>
	page {
		background-color: #F0F0F0;
	}
	.has-pd-20 {
		padding: 40rpx 0;
	}
	.has-pdb-15 {
		padding-bottom: 20rpx;
	}
	.logoimg {
		width: 200rpx;
		height: 200rpx;
		border-radius: 50%;
	}
	.courseTag {
		margin-right: 20rpx;
	}
	.uni-form-item .title {
		padding: 20upx 0;
	}
	.uni-form-item .uni-input {
		background-color: #e8e8e8;
		margin-bottom: 20rpx;
	}
</style>
