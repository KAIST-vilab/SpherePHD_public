import tensorflow as tf
import numpy as np
import time
import datetime
import os
import math
import matplotlib.pyplot as plt

from params import *
from network import conv_net, weights, biases
from loadTable import convTable, poolTable
from loadData import *

np.set_printoptions(threshold=np.nan)
os.environ["CUDA_VISIBLE_DEVICES"] = "3"

TRAIN_MODE = False

X = tf.placeholder(tf.float32, [None, 1, inWidth, inChannel])
Y = tf.placeholder(tf.float32, [None, num_classes])


logits = conv_net(X, weights, biases, convTable, poolTable, div)
prediction = tf.nn.softmax(logits)

loss_op = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits_v2(logits=logits, labels=Y))
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate)
train_op = optimizer.minimize(loss_op)

# Evaluate model
correct_pred = tf.equal(tf.argmax(prediction, 1), tf.argmax(Y, 1))
accuracy = tf.reduce_mean(tf.cast(correct_pred, tf.float32))

# Initialize the variables (i.e. assign their default value)
init = tf.global_variables_initializer()

start_time = time.time()
saver = tf.train.Saver()

# Start training
config = tf.ConfigProto()
config.gpu_options.per_process_gpu_memory_fraction = 1
config.gpu_options.allow_growth = True

# Training loop


sess = tf.Session(config=config)
sess = tf.Session()
sess.run(init)
saver.restore(sess, "./save/MNIST_Sphere_model.ckpt")
if TRAIN_MODE:
    print("Training start")
    for epoch in range(num_epochs):
        print("epoch {}".format(epoch))
        for idx in range(1,2):
            train_images, train_labels = loadTrainData(idx)
            for step in range(1, num_steps + 1):
                batch_x, batch_y = np.reshape(train_images[(step - 1) * batch_size:step * batch_size].astype(np.float32),
                                              [batch_size, 1, 1280, 1]), train_labels[
                                                                          (step - 1) * batch_size:step * batch_size].astype(
                    np.float32)

                sess.run(train_op, feed_dict={X: batch_x, Y: batch_y})

                if step % 1000 == 0:
                    loss, acc = sess.run([loss_op, accuracy], feed_dict={X: batch_x, Y: batch_y})
                    print("Step " + str((idx-1)*num_steps+step) + ", Minibatch Loss= " +"{:.4f}".format(loss) + ", Training Accuracy= " + "{:.3f}".format(acc))

    save_file_path = "./save/MNIST_Sphere_model.ckpt"
    save_path = saver.save(sess, save_file_path)
    print("Model saved in path: %s" % save_path)
    print("Training finish")

print("Testing start")
total_accuracy = 0
for idx in range(1,2):
    test_images, test_labels = loadTestData(idx)
    for step in range(1, 501):
        batch_x, batch_y = np.reshape(test_images[(step - 1) * batch_size:step * batch_size].astype(np.float32),
                                       [batch_size, 1, 1280, 1]), test_labels[
                                                                  (step - 1) * batch_size:step * batch_size].astype(
            np.float32)
        acc = sess.run([accuracy], feed_dict={X: batch_x, Y: batch_y})
        total_accuracy = total_accuracy + acc[0]
total_accuracy *= batch_size
print("Total accuracy is {}%".format(total_accuracy/100))
sess.close()

