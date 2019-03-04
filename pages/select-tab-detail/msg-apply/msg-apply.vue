<template>
	<view class="uni-padding-wrap uni-common-mt">
		<form @submit="formSubmit">
			<view class="uni-form-item uni-column">
				<view class="title">请选择被查看人角色</view>
				<view class="uni-list">
					<radio-group @change="radioChange" name="role">
						<label class="uni-list-cell uni-list-cell-pd" v-for="(item, index) in items" :key="item.value">
							<view>{{item.name}}</view>
							<view>
								<radio :value="item.value" :checked="index === current" />
							</view>
						</label>
					</radio-group>
				</view>
			</view>
			<view class="uni-form-item uni-column">
				<view class="title">申请理由</view>
				<view class="uni-textarea">
					<textarea placeholder="请输入理由" name="content" maxlength="-1" :auto-height="true" />
				</view>
			</view>
			<view class="uni-form-item uni-column">
				<view class="uni-title">公告范围</view>
				<view class="uni-list">
					<view class="uni-list-cell uni-list-cell-pd">
						<view class="uni-list-cell-db" v-if="isAllCollege">全校发送</view>
						<view class="uni-list-cell-db" v-if="!isAllCollege">指定学院发送</view>
						<switch :checked="isAllCollege" name="isAllCollege" @change="switchChange" />
					</view>
				</view>
			</view>
			<view class="uni-form-item uni-column" v-if="!isAllCollege">
				<view class="uni-title">选择可查看的学院</view>
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
			<view class="uni-form-item uni-column" v-if="!isAllCollege">
				<view class="uni-title">选择可查看的专业</view>
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
				isAllCollege: true,
				items: [{
						value: '1',
						name: '学生',
						checked: 'true'
					},
					{
						value: '2',
						name: '教师',
					},
				],
				current: 0
			}
		},
		methods: {
			formSubmit: function(e) {
				uni.showLoading({
					title: '加载中'
				});				
				let formData = e.detail.value
				uni.getStorage({
					key: 'userInfo',
					success: function(res) {
						let userInfo = res.data
						let param = {
							notice_tea_id: userInfo.tea_id,
							notice_title: formData.title,
							notice_content: formData.content,
							college_id: formData.collegeId,
							major_id: formData.majorId,
							notice_is_all: formData.isAllCollege ? 1 : 0
						}
						uni.request({
							url: 'http://localhost/stuTeaCtct/index.php/app/nt_mgt/save_notice',
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
											url:'/pages/tabbar/home/home'
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
				console.log(e.target.value)
				this.majorIndex = e.target.value
			},
			switchChange: function (e) {
				this.isAllCollege = e.target.value
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
					}
				});				
			},
			radioChange: function(evt) {
				for (let i = 0; i < this.items.length; i++) {
					if (this.items[i].value === evt.target.value) {
						this.current = i;
						break;
					}
				}
			}
		},
		onLoad: function () {
			this.getCollege()
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
