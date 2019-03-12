<template>
	<view class="uni-padding-wrap uni-common-mt">
		<form @submit="formSubmit">
			<view class="uni-form-item uni-column">
				<view class="title">选择被查看人角色</view>
				<view class="uni-list">
					<radio-group @change="roleChange" name="role">
						<label class="uni-list-cell uni-list-cell-pd" v-for="(item, index) in roleArr" :key="item.value">
							<view>{{item.name}}</view>
							<view>
								<radio :value="item.value" :checked="index === currentRole" />
							</view>
						</label>
					</radio-group>
				</view>
			</view>
			<view class="uni-form-item uni-column" v-if="collegeArr.length !== 0">
				<view class="uni-title">选择被查看人的学院</view>
				<view class="uni-list">
					<view class="uni-list-cell">
						<view class="uni-list-cell-left">
							当前选择
						</view>
						<view class="uni-list-cell-db">
							<picker @change="bindCollegePickerChange" :value="collegeIndex" 
								range-key="college_name" :range="collegeArr" name="collegeId">
								<view class="uni-input">{{collegeArr[collegeIndex].college_name}}</view>
							</picker>
						</view>
					</view>
				</view>
			</view>
			<view class="uni-form-item uni-column" v-if="majorArr.length !== 0">
				<view class="uni-title">选择被查看人的专业</view>
				<view class="uni-list">
					<view class="uni-list-cell">
						<view class="uni-list-cell-left">
							当前选择
						</view>
						<view class="uni-list-cell-db">
							<picker  @change="bindMajorPickerChange" :value="majorIndex" 
								:range="majorArr" range-key="major_name" name="majorId">
								<view class="uni-input">{{majorArr[majorIndex].major_name}}</view>
							</picker>
						</view>
					</view>
				</view>
			</view>
			<view class="uni-form-item uni-column" v-if="collegeId && majorId">
				<view class="uni-title">选择被查看人</view>
				<navigator hover-class="navigator-hover"
					:url="'/pages/phones/phones?collegeId='+collegeId+'&majorId='+majorId+'&roleId='+roleId" >
					<button type="default">
						{{ selectedName.length === 0 ? '从通讯录中选择' : '已选：' + selectedName }}
					</button>
				</navigator>
			</view>
			<view class="uni-form-item uni-column">
				<view class="title">申请理由</view>
				<view class="uni-textarea">
					<textarea placeholder="请输入理由" name="applyReason" maxlength="-1" :auto-height="true" />
				</view>
			</view>
			<view class="uni-btn-v">
				<button formType="submit" type="primary">提交申请</button>
			</view>
		</form>
	</view>
</template>
<script>
	export default {
		data() {
			return {
				collegeArr: [],
				collegeIndex: 0,
				collegeId: '',
				majorArr: [],
				majorIndex: 0,
				majorId: '',
				roleArr: [],
				currentRole: 0,
				roleId: '2', // 默认为学生
				selectedName: '',
				selectId: ''
			}
		},
		methods: {
			formSubmit: function(e) {
				let that = this
				uni.showLoading({
					title: '加载中'
				});				
				let formData = e.detail.value
				if (that.selectedName.length === 0) {
					uni.showToast({
						title: '请选择被查看人',
						icon: 'none'
					})
					return
				}
				if (formData.applyReason.length === 0) {
					uni.showToast({
						title: '请填写申请原因',
						icon: 'none'
					})
					return
				}
				uni.getStorage({
					key: 'userInfo',
					success: function(res) {
						let userInfo = res.data
						let param = {
							apply_reason: formData.applyReason,
							apply_user_id: userInfo.stu_id ? userInfo.stu_id : userInfo.tea_id,
							apply_user_type: userInfo.role_id,
							check_user_id: that.selectId,
							check_user_type: that.roleId,
							check_user_name: that.selectedName
						}
						console.log(param)
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
			},
			bindCollegePickerChange: function(e) {
				this.collegeIndex = e.target.value
				this.getMajorByCollegeId()
			},
			bindMajorPickerChange: function (e) {
				// console.log(e.target.value)
				this.majorIndex = e.target.value
				this.majorId = this.majorArr[this.majorIndex].major_id
			},
			getRole: function () {
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/role/getRole',
					method:'POST',
					data: {},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						let data = res.data
						data.forEach((obj,index) => {
							if (index === 0) {
								this.roleArr.push({
									value: obj.role_id,
									name: obj.role_name,
									checked: 'true'
								})
							} else {
								this.roleArr.push({
									value: obj.role_id,
									name: obj.role_name,
								})
							}
						})
						// this.roleId = this.roleArr[0].value
						this.roleChange({target:{value: this.roleId}})
					}
				});
			},
			getCollege: function () {
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/college/getCollege',
					method:'POST',
					data: {},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.collegeArr = res.data
						this.getMajorByCollegeId()
					}
				});				
			},
			getMajorByCollegeId: function () {
				this.majorIndex = 0
				this.collegeId = this.collegeArr[this.collegeIndex].college_id
				uni.request({
					url: 'http://localhost/stuTeaCtct/index.php/app/major/getMajorByCollege',
					method:'POST',
					data: {
						collegeId : this.collegeId
					},
					header: {
						'content-type' : 'application/x-www-form-urlencoded'
					},
					success: (res) => {
						this.majorArr = res.data
						this.majorId = this.majorArr[this.majorIndex].major_id
					}
				});				
			},
			roleChange: function(evt) {	//	角色变换触发事件
				this.roleId = evt.target.value
				for (let i = 0; i < this.roleArr.length; i++) {
					if (this.roleArr[i].value === this.roleId) {
						this.currentRole = i;
						break;
					}
				}
			}
		},
		onLoad: function (option) {
			this.getCollege()	//	获取学院
			this.getRole()	//	获取角色
			if (JSON.stringify(option) !== '{}') {
				this.selectedName = option.name
				this.selectId = option.id
				this.roleId = option.roleId
			}
		}
	}
</script>

<style scoped>
	.uni-form-item .title {
		padding: 20upx 0;
	}
	page {
		background-color: #F0F0F0;
	}
</style>
