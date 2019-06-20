import tensorflow as tf
import numpy as np

def loadTestData(idx):
    test_tf_filename = './sphereData/test/MNIST_Sphere_test_div3_rotate_'
    test_tf_filename = test_tf_filename + str(idx) + '.tfrecord'
    record_iterator = tf.python_io.tf_record_iterator(path=test_tf_filename)
    test_images = []
    test_labels = []

    for string_record in record_iterator:
        example = tf.train.Example()
        example.ParseFromString(string_record)

        num_items = int(example.features.feature['num_items']
                        .int64_list
                        .value[0])

        div_num = int(example.features.feature['div_num']
                      .int64_list
                      .value[0])

        label = (example.features.feature['label']
            .int64_list
            .value[0])

        image_raw = (example.features.feature['image_raw']
            .bytes_list
            .value[0])

        buf = np.frombuffer(image_raw, dtype=np.uint8)
        buf = np.reshape(buf, [1, 1280])
        test_images.append(buf)
        test_labels.append(label)

    test_images = np.asarray(test_images)
    test_labels = np.asarray(test_labels)

    onehot_label = np.zeros((10000, 10))
    indices = np.arange(10000).astype(int)
    onehot_label[indices, test_labels] = 1

    return test_images, onehot_label


def loadTrainData(idx):
    train_tf_filename = './sphereData/train/MNIST_Sphere_train_surface_uniform_div3_rotate_'
    train_tf_filename = train_tf_filename + str(idx) + '.tfrecord'

    record_iterator = tf.python_io.tf_record_iterator(path=train_tf_filename)
    train_images = []
    train_labels = []

    for string_record in record_iterator:
        example = tf.train.Example()
        example.ParseFromString(string_record)

        num_items = int(example.features.feature['num_items']
                        .int64_list
                        .value[0])

        div_num = int(example.features.feature['div_num']
                      .int64_list
                      .value[0])

        label = (example.features.feature['label']
            .int64_list
            .value[0])

        image_raw = (example.features.feature['image_raw']
            .bytes_list
            .value[0])

        buf = np.frombuffer(image_raw, dtype=np.uint8)
        buf = np.reshape(buf, [1, 1280])
        train_images.append(buf)
        train_labels.append(label)

    train_images = np.asarray(train_images)
    train_labels = np.asarray(train_labels)

    onehot_label = np.zeros((60000, 10))
    indices = np.arange(60000).astype(int)
    onehot_label[indices, train_labels] = 1

    return train_images, onehot_label